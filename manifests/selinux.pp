class icinga2::selinux {

case $::operatingsystem {
  'CentOS','Redhat': {
        
	exec { '/tmp/reboot':
                path    => "/usr/bin:/bin:/sbin",
                command => 'touch /tmp/reboot',
                onlyif => 'test ! -f /tmp/rebooted', }
        exec {'selinux':
		command => "sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config",
                path => "/bin",
                require => Exec['/tmp/reboot'] ,	}

        exec { 'reboot':
                command => "mv /tmp/reboot /tmp/rebooted; reboot",
                path    => "/usr/bin:/bin:/sbin",
                onlyif  => "test -f /tmp/reboot",
                require =>  Exec['selinux'],
                creates => '/tmp/rebooted', 	}
	
	class{	'icinga2::files': 
		require => Exec['selinux'] }
	
 	 notify { "Disabling SELINUX on  $::operatingsystem and Icinga2 Installation will start subsequently ..... "  : }
	}

'Debian', 'Ubuntu': {

	contain icinga2::files
		notify { " This is $::operatingsystem and Icinga2 Installation is started ....."  : } 	
			}
		}			
	}






