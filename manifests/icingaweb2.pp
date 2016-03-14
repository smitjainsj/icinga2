
class icinga2::icingaweb2 inherits icinga2::params

{	
	contain icinga2::mysql

	$packages = [ $icinga2web_package , $icinga2cli , $plugins  ]
	
	package { $packages: 
		ensure => installed, 	
		require => Package[$mysql_package],
		}

	exec { "Enable_Features_$icinga2_package":
               command => "icinga2 feature  enable command compatlog syslog",
               notify  => Service[$icinga2_service],
               }

	exec { "Configure_$icinga2web_package":
                command => "cp -rf  /opt/icingaweb2/ /usr/share/icingaweb2/; \
                        icingacli module enable setup ; \
                        icingacli setup config webserver apache --document-root $document_root  > $apache_conf; \
                        $usermod $icinga2web_grp $apache_user ; \
                        service $apache_service restart 2> /dev/null  ; \
                        icingacli setup config directory " ,
			require => Package[$icinga2web_package],
                }

        exec{ "Create_DB_$icinga2web_package":
                unless  => "mysql -u$icinga2web_dbuser -p$icinga2web_dbpass $icinga2web_dbname ; " ,
		command => "mysql -uroot -e  \"create database ${icinga2web_dbname} ; \
                        GRANT ALL  ON ${icinga2web_dbname}.* TO  ${icinga2web_dbuser}@${host} IDENTIFIED BY '${icinga2web_dbpass}' ;\" ; \
                        mysql -uroot  ${icinga2web_dbname} < $mysql_icinga2web_schema ; \
                    mysql -uroot $icinga2web_dbname  -e 'INSERT INTO icingaweb_user (name, active, password_hash) VALUES (\"icingaadmin\",1,\"$icinga2web_pass_hash\");' " ,
                        require => Exec["Configure_$icinga2web_package"],
                }
}
