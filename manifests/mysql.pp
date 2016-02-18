class icinga2::mysql inherits icinga2::params

 {

       $packages = [ $mysql_package, $mysql_client, $icinga2_ido,]
        
	package { $packages: 
		ensure => installed, 
		}

	service { $mysql_service:
                ensure => running,
                enable => true,
                require => Package[$mysql_package],
                }

	exec { 'Creating DB Icinga2':
		path    => ['/usr/sbin/','/usr/bin/','/bin','/usr/local/bin',],
		unless	=> "mysql -u$icinga2_dbuser -p$icinga2_dbpass $icinga2_dbname ; " ,
		command => "mysql -uroot -e  \"create database ${icinga2_dbname} ; \
		GRANT ALL  ON ${icinga2_dbname}.* TO  ${icinga2_dbuser}@${host} IDENTIFIED BY  '${icinga2_dbpass}' ; \" ; \
		mysql -uroot  ${icinga2_dbname} < $mysql_icinga2_schema ; \
		icinga2 feature enable ido-mysql ; \
		$usermod $webserver_grp $apache_user ; " , 
		require => File['/etc/icinga2/features-available/ido-mysql.conf'],
	}

	file { '/etc/icinga2/features-available/ido-mysql.conf':
		source => 'puppet:///modules/icinga2/ido-mysql.conf' ,
		ensure => 'present' ,
		owner  => $webserver_grp,
		group  => $webserver_grp,
		mode   => '0600',
		notify => Service[$icinga2_service],
		require => Package[$icinga2_ido],
	}

}




	


