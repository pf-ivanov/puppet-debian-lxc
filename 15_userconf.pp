if (!defined('lxc_user')) { $lxc_user = $myuser }
if (!defined('lxc_uid')) { $lxc_uid = $myuid }
if (!defined('lxc_gid')) { $lxc_gid = $mygid }

file {
    [
        "/home/$lxc_user/.config",
        "/home/$lxc_user/.config/lxc",
        "/home/$lxc_user/.local",
        "/home/$lxc_user/.local/share",
        "/home/$lxc_user/.local/share/lxc",
        "/home/$lxc_user/.local/share/lxcsnaps",
        "/home/$lxc_user/.cache",
        "/home/$lxc_user/.cache/lxc",
    ]:
        ensure => directory,
        owner => $lxc_uid,
        group => $lxc_gid;
    [
        "/home/$lxc_user/.config/lxc/lxc.conf",
        "/home/$lxc_user/.config/lxc/default.conf",
    ]:
        ensure => present,
        owner => $lxc_uid,
        group => $lxc_gid;
}
ini_setting {
    'unprivileged_userns_clone':
        notify  => Exec['refresh-sysctl'],
        path    => '/etc/sysctl.d/80-lxc-userns.conf',
	setting => 'kernel.unprivileged_userns_clone',
	value   => 1;
}
$subuid_end = $subuid_next + 65535
$subgid_end = $subgid_next + 65535
file_line {
    'uid_map':
        path => "/home/$lxc_user/.config/lxc/default.conf",
        line => "lxc.id_map = u 0 $subuid_next 65536";
    'gid_map':
        path => "/home/$lxc_user/.config/lxc/default.conf",
        line => "lxc.id_map = g 0 $subuid_next 65536";
}
exec {
    'refresh-sysctl':
        command     => 'sysctl --system',
	refreshonly => true;
    'set-subuid':
        command => "usermod --add-subuids $subuid_next-$subuid_end $lxc_user",
	unless  => "grep '$lxc_user:$subuid_next:65536' /etc/subuid";
    'set-subgid':
        command => "usermod --add-subgids $subgid_next-$subgid_end $lxc_user",
	unless  => "grep '$lxc_user:$subgid_next:65536' /etc/subgid";
}

