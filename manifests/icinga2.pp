############# This Class will install ICINGA2,APACHE,MYSQL,GIT
#############

class basemod::icinga2 inherits basemod::params

{
# class { 'basemod::selinux': }
 class { 'basemod::mysql': }      
	

	$packages = [ $icinga2_package,
		$icinga2_ido,
                $git_package,
		$apache_package,]
		
	package { $packages: 
		ensure => installed, 
		require => Package[$mysql_package],
		}

	service { ['$icinga2_service','$apache_service'] :
               ensure => running,
               enable => true,
               require => Package[$icinga2_package],
	
	}


	exec { "Enable $icinga2_ido Module":
		path    => ['/usr/sbin/'],
		command => "icinga2 feature  enable $icinga2_ido_module",
		require => Service[$mysql_service],
	}


}
