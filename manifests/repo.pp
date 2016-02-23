class icinga2::repo  inherits icinga2::params 
{
   exec { 'icinga2-repo':
                  unless => '/usr/bin/apt-key list |  grep icinga' ,
                  command => 'wget -O - http://packages.icinga.org/icinga.key | apt-key add -  ; \
				/usr/bin/add-apt-repository  ppa:formorer/icinga' ,
                  notify => Exec['icinga-apt-update'],
          }


     exec { 'icinga-apt-update':
            command => '/usr/bin/apt-get update',
            refreshonly => true ,

     }	
	class{'icinga2::icinga':
		require => Exec['icinga-apt-update'],
	}
	

}
