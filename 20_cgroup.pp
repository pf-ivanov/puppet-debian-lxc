file {
    '/etc/sysconfig': ensure => directory;
    '/etc/cgconfig.conf': content => template('base/cgconfig.conf.erb');
}
exec {
    'cp-cgred':
        require => [Package['cgroup-tools'],File['/etc/sysconfig']],
        command => 'cp /usr/share/doc/cgroup-tools/examples/cgred.conf /etc/sysconfig/cgred.conf',
	creates => '/etc/sysconfig/cgred.conf';
}

