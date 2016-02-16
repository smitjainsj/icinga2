class icinga2::files inherits icinga2::params

{

file { [ '/etc/icingaweb2/modules', '/etc/icingaweb2/modules/monitoring', ] :
					         ensure => 'directory' ,
					         owner => 'root',
					         recurse => 'true',
					         group => 'root',
					         mode => '0750',
					         }

File {
	ensure => 'present' ,
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
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
	
}

