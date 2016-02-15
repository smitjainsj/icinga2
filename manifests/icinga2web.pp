
class icinga2::icinga2web inherits icinga2::params

{

	exec {"Configure Icinga2 Web":
	path    => ['/usr/sbin/','/usr/bin/','/bin','/usr/local/bin',],
	command => "icinga2 feature  enable command ; \
	cp -r  /opt/icingaweb2/ /usr/share/icingaweb2/; \
	icingacli setup config webserver apache --document-root $document_root  > $apache_conf ; \
	a2enconf $icinga2web_package ; \

	$groupadd $icinga2web_grp ; \
	$usermod $icinga2web_grp $apache_user ; \
	service $apache_service restart ; \
	icingacli setup config directory ; \ 

	mysql -uroot  ${icinga2web_dbname} < $mysql_icinga_schema ; \ 
	mysql -uroot -e \"INSERT INTO icingaweb_user (name, active, password_hash) VALUES ('icingaadmin',1,'$icinga2web_pass_hash');\" ",
	
	require => Package[$icinga2web_package],
	notify => Service[$icinga2_service],
	
	}
}
