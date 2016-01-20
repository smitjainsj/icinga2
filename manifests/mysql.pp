class basemod::mysql inherits basemod::params

 {
        package { $mysql_package: ensure => installed, }

        service { $mysql_service:
                ensure => running,
                enable => true,
                require => Package[$mysql_package],
                }

}
