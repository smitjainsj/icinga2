class icinga2::mysql inherits icinga2::params

 {
        package { $mysql_package: ensure => installed, }

        service { $mysql_service:
                ensure => running,
                enable => true,
                require => Package[$mysql_package],
                }

	exec { "Creating DB for Icinga2Web" :
 	path    => ['/usr/sbin/','/usr/bin/','/bin','/usr/local/bin',],

	command => " mysql -uroot -e  \"create database ${icinga2web_dbname} ;   
	GRANT ALL  ON ${icinga2web_dbname}.* TO  ${icinga2web_dbuser}@${host} IDENTIFIED BY  '${icinga2web_dbpass}' ; quit; \" 
        mysql -uroot -p ${icinga2web_dbname} < /usr/share/icingaweb2/icingaweb2/etc/schema/mysql.schema.sql ; " ,
	require => Service[$mysql_service],
		}
}	


