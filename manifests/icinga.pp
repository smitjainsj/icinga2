
class icinga2::icinga inherits icinga2::params

{
 
	$packages = [ $icinga2_package,
                $git_package,
		$apache_package,
		]
		
	package { $packages: 
		##provider => $provider ,
		ensure => installed , 
		}

	$services =  [ $icinga2_service, $apache_service , ] 
	
	service { $services :                
		ensure => running,
    		enable => true,
		require => Package[$apache_package],	
		notify => Exec['apache2-update'],
	}
		exec{ 'apache2-update': command => "$update", }


	class{'icinga2::git': 
			require => Package[$apache_package], }



}


