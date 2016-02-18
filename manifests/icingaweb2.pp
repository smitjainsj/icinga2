
class icinga2::icingaweb2 inherits icinga2::params

{
	#include icinga2::mysql
	#include icinga2::git_repo
	#Class['icinga2::mysql'] -> Class['icinga2::git_repo']
	
	$packages = [ $icinga2web_package ]
	
	package { $packages: 
		ensure => installed, 
		require => Package[$icinga2_package],	
	}

	exec {"Configure Icinga2 Web":
	path    => ['/usr/sbin/','/usr/bin/','/bin','/usr/local/bin',],
	command => " icinga2 feature  enable command compatlog syslog ; \
	cp -r  /opt/icingaweb2/ /usr/share/icingaweb2/; \
	icingacli module enable setup ; \
	icingacli setup config webserver apache --document-root $document_root  > $apache_conf ; \
	$usermod $icinga2web_grp $apache_user ; \
	service $apache_service restart 2> /dev/null  ; \
	icingacli setup config directory ; \ 
	mysql -uroot -e  \"create database ${icinga2web_dbname} ; \
	GRANT ALL  ON ${icinga2web_dbname}.* TO  ${icinga2web_dbuser}@${host} IDENTIFIED BY  '${icinga2web_dbpass}';\" ; \
	mysql -uroot  ${icinga2web_dbname} < $mysql_icinga2web_schema ; \ 
	mysql -uroot -e \"INSERT INTO icingaweb_user (name, active, password_hash) VALUES ('icingaadmin',1,'$icinga2web_pass_hash');\" ; " ,
	require => Package[$icinga2_package],
	notify => Service[$icinga2_service],	

	}
}
