
class icinga2::icingacore inherits icinga2::params


{
 case $::operatingsystem {

  'CentOS','Redhat': {
	exec { 'icinga2-repo':
                  unless => "/bin/rpm -q 'gpg-pubkey-*' --qf '%{name}-%{version}-%{release} -> %{summary}\n ' |  grep icinga" ,
                  command => "/bin/rpm --import http://packages.icinga.org/icinga.key ; \
				/usr/bin/curl -o /etc/yum.repos.d/ICINGA-release.repo http://packages.icinga.org/epel/ICINGA-release.repo ;",
                  notify => Exec['icinga-repo-update'],          }
		
	exec { 'icinga-repo-update':
		command => '/usr/bin/yum repolist all && yum makecache ',
		refreshonly => true, }
	
	}

 'Debian', 'Ubuntu': {
	exec { 'icinga2-repo':
		unless => '/usr/bin/apt-key list |  grep icinga' ,
		command => 'wget -O - http://packages.icinga.org/icinga.key | apt-key add -  ; \
				/usr/bin/add-apt-repository  ppa:formorer/icinga' ,
		notify => Exec['icinga-repo-update'],}
	exec { 'icinga-repo-update':
		command => '/usr/bin/apt-get update',
		refreshonly => true, }	
		}
	}	
	$packages = [ $icinga2_package	]
		
	package { $packages: 
		##provider => $provider ,
		ensure => installed , 
		requrire => Exec['icinga2-repo'],
		}

	$services =  [ $icinga2_service ] 
	
	service { $services :                
		ensure => running,
    		enable => true,
		require => Package[$icinga2_package],	
	}

}


