
class icinga2::icinga inherits icinga2::params

{ 
	$packages = [ $icinga2_package,
                $git_package,
		$apache_package,
		]
		
	package { $packages: 
		ensure => installed , 
		}

	$services =  [ $icinga2_service, $apache_service , ] 
	
	service { $services :                
		ensure => running,
		enable => true,
		require => Package[$icinga2_package],	
	}
}
