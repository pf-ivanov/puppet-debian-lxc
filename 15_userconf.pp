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
$subid_end = $subid_start + 65535
exec {
    'refresh-sysctl':
        command     => 'sysctl --system',
	refreshonly => true;
    'set-subuid':
        command => "usermod --add-subuids $subid_start-$subid_end $lxc_user",
	unless  => "grep '$lxc_user:$subid_start:65536' /etc/subuid";
    'set-subgid':
        command => "usermod --add-subgids $subid_start-$subid_end $lxc_user",
	unless  => "grep '$lxc_user:$subid_start:65536' /etc/subgid";
}
file_line {
    'uid_map':
        path => "/home/$lxc_user/.config/lxc/default.conf",
        line => "lxc.id_map = u 0 $subid_start 65536";
    'gid_map':
        path => "/home/$lxc_user/.config/lxc/default.conf",
        line => "lxc.id_map = g 0 $subid_start 65536";
}
