class icinga2::files inherits icinga2::params

{

File {
	ensure => 'present',
	owner  => 'root',
	group  => 'root',
	mode   => '0644',
}


file {  
	'/etc/icingaweb2/resources.ini' :
	content => template('icinga2/resources.erb'),

	'/etc/icingaweb2/config.ini' :
	content => template('icinga2/config.erb '),

	'/etc/icingaweb2/authentication.ini':
	content => template('icinga2/authentication.erb'),

	'/etc/icingaweb2/modules/monitoring/config.ini':
	content => template('icinga2/monitor_config.erb'),

	'/etc/icingaweb2/modules/monitoring/backends.ini'
	content => template('icinga2/backends.erb'),

	'/etc/icingaweb2/modules/monitoring/commandtransports.ini'
	content => template('icinga2/commandtransports.erb') ,

	require => Class['icinga2::icinga2web'],
	notify => Service[$icinga2_service],
}
	
}
