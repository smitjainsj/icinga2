class icinga2::mysql inherits icinga2::params

 {
       $packages = [ $mysql_package,
                $icinga2_ido, ]
        
	package { $packages: 
		ensure => installed, 
		}

	service { $mysql_service:
                ensure => running,
                enable => true,
                require => Package[$mysql_package],
                }

##	exec { 'Creating DB Icinga2':
##	path    => ['/usr/sbin/','/usr/bin/','/bin','/usr/local/bin',],
##	command => "mysql -uroot -e  \"create database ${icinga2_dbname} ; \
##	GRANT ALL  ON ${icinga2_dbname}.* TO  ${icinga2_dbuser}@${host} IDENTIFIED BY  '${icinga2_dbpass}' ; \" ; \
##	mysql -uroot  ${icinga2_dbname} < /usr/share/icinga2-ido-mysql/schema/mysql.sql ; " , 
##	require => Service[$mysql_service],		}

}	


