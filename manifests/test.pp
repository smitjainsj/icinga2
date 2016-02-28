
class icinga2::test inherits icinga2::params {


 $pack1 = [ $mysql_package, $mysql_client ]
        
	package { $pack1: 
		provider => $provider,
		ensure => installed, 
		}

}
