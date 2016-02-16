
class icinga2::icinga2web inherits icinga2::params

{

	exec {"Configure Icinga2 Web":
	path    => ['/usr/sbin/','/usr/bin/','/bin','/usr/local/bin',],
	command => "icinga2 feature  enable command ; \
	cp -r  /opt/icingaweb2/ /usr/share/icingaweb2/; \
	icingacli module enable setup ; \
	icingacli setup config webserver apache --document-root $document_root  > $apache_conf ; \
	a2enconf $icinga2web_package ; \
	$usermod $icinga2web_grp $apache_user ; \
	service $apache_service restart 2> /dev/null  ; \
	icingacli setup config directory ; \ 
	mysql -uroot -e  \"create database ${icinga2web_dbname} ; GRANT ALL  ON ${icinga2web_dbname}.* TO  ${icinga2web_dbuser}@${host} IDENTIFIED BY  '${icinga2web_dbpass}' ; \" ; \
	mysql -uroot  ${icinga2web_dbname} < $mysql_icinga2web_schema ; \ 
	mysql -uroot -e \"INSERT INTO icingaweb_user (name, active, password_hash) VALUES ('icingaadmin',1,'$icinga2web_pass_hash'); \" ; \
	service icinga2 restart 2> /dev/null ;  " ,
	require => Package[$icinga2web_package],
	
	}
}
