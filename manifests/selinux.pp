class basemod::selinux {

        exec { '/tmp/reboot':
                path    => "/usr/bin:/bin:/sbin",
                command => 'touch /tmp/reboot',
                onlyif => 'test ! -f /tmp/rebooted',
        }

        exec {'selinux':
                command => "sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config",
                path => "/bin",
                require => Exec['/tmp/reboot']
                }

        exec { 'reboot':
                command => "mv /tmp/reboot /tmp/rebooted; reboot",
                path    => "/usr/bin:/bin:/sbin",
                onlyif  => "test -f /tmp/reboot",
                require =>  Exec['selinux'],
                creates => '/tmp/rebooted',

        }
 }
