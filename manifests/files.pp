class icinga2::files inherits icinga2::params

{


contain icinga2::icingaweb2

file { [ '/etc/icingaweb2/modules', '/etc/icingaweb2/modules/monitoring', ] :
         ensure => 'directory' ,
         owner => $apache_user,
         recurse => 'true',
         group => $icinga2web_grp,
         mode => '0755',
         }

File {
	ensure => 'present' ,
        owner  => $apache_user,
        group  => $icinga2web_grp,
        mode   => '0755',
	require => Package[$icinga2web_package],
}
file {  
	'/etc/icingaweb2/resources.ini':
	source  => 'puppet:///modules/icinga2/resources.ini' ;
	
	'/etc/icingaweb2/config.ini':
	source => 'puppet:///modules/icinga2/config.ini' ;
	
	'/etc/icingaweb2/authentication.ini':
	source  => 'puppet:///modules/icinga2/authentication.ini' ;
	
	'/etc/icingaweb2/roles.ini':
	source => 'puppet:///modules/icinga2/roles.ini' ;

	'/etc/icingaweb2/modules/monitoring/config.ini':
	source  => 'puppet:///modules/icinga2/monitor_config.ini' ;
	
	'/etc/icingaweb2/modules/monitoring/backends.ini':
	source => 'puppet:///modules/icinga2/backends.ini' ;
	
	'/etc/icingaweb2/modules/monitoring/commandtransports.ini':
	source  => 'puppet:///modules/icinga2/commandtransports.ini' ;
	
	}

file { ['/etc/icingaweb2/enabledModules'] :
	ensure => 'directory' ,
         owner => $apache_user,
         recurse => 'true',
         group => $icinga2web_grp,
         mode => '0755',
         }
	
}

