
class icinga2::icinga inherits icinga2::params

{ 
	$packages = [ $icinga2_package,
                $git_package,
		$apache_package,
		$icinga2web_package,
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
	exec { "Enable $icinga2_ido Module":
		path    => ['/usr/sbin/','/usr/bin/','/bin','/usr/local/bin',],
		command => "icinga2 feature  enable $icinga2_ido_module " ,
		require => Service[$mysql_service],
		notify => Service[$icinga2_service],
	}


}
