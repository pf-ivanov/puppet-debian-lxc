file {
    '/etc/sysconfig':     ensure  => directory;
    '/etc/cgconfig.conf': content => template('base/cgconfig.conf.erb');
    '/etc/cgrules.conf':  content => "$lxc_user * $lxc_user";
    '/lib/systemd/system/cgconfig.service':
        mode    => '0755',
        content => template('base/cgconfig.service');
} -> 
exec {
    'cp-cgred':
        require => Package['cgroup-tools'],
        command => 'cp /usr/share/doc/cgroup-tools/examples/cgred.conf /etc/sysconfig/cgred.conf',
	creates => '/etc/sysconfig/cgred.conf';
} ->
service { 'cgconfig':; }
