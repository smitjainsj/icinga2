
class icinga2::icinga2web inherits icinga2::params

{
class { 'icinga2::icinga': }

	$packages =[	$icinga2web_package,
		]
		
	package { $packages: 
		ensure => installed, 
		require => Service[$icinga2_service],
		}

	exec {"Configure Icinga2 Web":
		path    => ['/usr/sbin/','/usr/bin/','/bin','/usr/local/bin',],
		command => "icinga2 feature  enable $command ; \
	cd /tmp && git clone git://git.icinga.org/icingaweb2.git ; \
	mv icingaweb2/ /usr/share/icingaweb2/; \
icingacli setup config webserver apache --document-root /usr/share/icingaweb2/public > /etc/apache2/conf-available/icingaweb2.conf ; \
	a2enconf $icinga2web_package ; \
	addgroup --system $icinga2web_grp ; usermod -a -G $icinga2web_grp www-data ; \
	service $apache_service restart ; \
	icingacli setup config directory ; ",

		require => Class[icinga],

	
	}
}
