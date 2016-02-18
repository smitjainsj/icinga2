class icinga2::repo inherits icinga2::params {

	exec { 'Add-icinga2-apt-key':
		unless => '/usr/bin/apt-key list |  grep icinga' ,
		command => '/usr/bin/wget -O - http://packages.icinga.org/icinga.key | apt-key add - ' ,
		notify => Exec['icinga-apt-update'],
	}

	exec { 'icinga-apt-update':
		command => '/usr/bin/apt-get update',
		require => File['/etc/apt/sources.list.d/formorer-icinga-trusty.list'] ,
		refreshonly => true ,
	}
	
	file { '/etc/apt/sources.list.d/formorer-icinga-trusty.list':
		content => 'deb http://packages.icinga.org/ubuntu icinga-trusty main',
		notify => Exec['icinga-apt-update'],	
		}
	
}
