package { ['lxc', 'bridge-utils', 'libvirt-bin', 'cgroup-tools', 'cgroupfs-mount', 'uidmap', 'debootstrap', 'yum']:; }
ini_setting {
   'GRUB_CMDLINE_LINUX':
       notify  => Exec['update-grub'],
       path    => '/etc/default/grub',
       setting => 'GRUB_CMDLINE_LINUX',
       value   => '"cgroup_enable=memory swapaccount=1"';
}
exec {
    'update-grub':
        command     => 'update-grub',
	refreshonly => true;
}

