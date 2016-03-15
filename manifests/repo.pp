class icinga2::repo  inherits icinga2::params 
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
	
	class{'icinga2::icinga': require => Exec['icinga-repo-update'], }
	}

 'Debian', 'Ubuntu': {
	exec { 'icinga2-repo':
		unless => '/usr/bin/apt-key list |  grep icinga' ,
		command => 'wget -O - http://packages.icinga.org/icinga.key | apt-key add -  ; \
				/usr/bin/add-apt-repository  ppa:formorer/icinga' ,
		notify => Exec['icinga-apt-update'],}
	exec { 'icinga-apt-update':
		command => '/usr/bin/apt-get update',
		refreshonly => true, }	
	
	class{'icinga2::icinga':	require => Exec['icinga-apt-update'],}
	
		}
	}	
}
