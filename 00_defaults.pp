Exec {
    path      => '/sbin:/usr/sbin:/bin:/usr/bin',
    logoutput => true
}
File {
    owner => root,
    group => root
}
Ini_setting {
    ensure  => present,
    section => '',
    key_val_separator => '='
}
Package { ensure => present }
Service {
    ensure => running,
    enable => true
}
