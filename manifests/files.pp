class icinga2::files inherits icinga2::params

{

File {
	ensure => 'present',
	owner  => 'root',
	group  => 'root',
	mode   => '0644',
}


file {  
	 '/etc/icingaweb2/resources.ini':
	content => template('icinga2/resources.erb');

	require => Class[icinga2::icinga2web],
	notify => Service[$icinga2_service],

	}
	
}

