class icinga2::params {

# Global Path for all the commands

Exec {
	path => ['/usr/bin/', '/sbin','/usr/local/bin','/bin', '/usr/sbin', ] 
}

# Password Hash for Icinga Web Login 
$icinga2web_pass_hash = generate( "/bin/bash" , "-c" , "/usr/bin/openssl passwd -1 icingaadmin  | tr -d '\n' ")


########## MySQL #########
$mysql_package		= 'mysql-server'
$host                   = 'localhost'
$git_package		= 'git'


######## ICINGA #########
$icinga2_package	= 'icinga2'
$icinga2_service	= 'icinga2'
$icinga2_dbname         = 'icinga'
$icinga2_dbuser         = $icinga2_dbname
$icinga2_dbpass         = $icinga2_dbname
$icinga2_ido		= 'icinga2-ido-mysql'
$icinga2_ido_module	= 'ido-mysql'
$icinga2web_package	= 'icingaweb2'
$icinga2web_grp		= $icinga2web_package
$icinga2web_dbname      = $icinga2web_package
$icinga2web_dbuser      = $icinga2web_dbname
$icinga2web_dbpass	= $icinga2web_dbuser
###$icinga2web_pass_hash 	= '$1$I5dgCL5I$Z7VOjgmTxJsaG0ZAQ/yZA0'

####### OTHERS #########
$document_root  	= '/usr/share/icingaweb2/public'	
$usermod		= 'usermod -a -G'
$mysql_icinga2_schema	= '/usr/share/icinga2-ido-mysql/schema/mysql.sql'
$mysql_icinga2web_schema = '/usr/share/icingaweb2/icingaweb2/etc/schema/mysql.schema.sql'

###### OS BASED ##########
case $::operatingsystemrelease { '15.10','15.04':{ $provider = 'base'} 
				 '14.10','14.04':{ $provider = 'upstart' } 
				 '6.\*' : {$provider = 'yum'} }
			

case $::operatingsystem {

  'CentOS','Redhat': {

	$ntp_service    = 'ntpd'
	$ssh_service    = 'sshd'
	$mysql_service  = 'mysqld'
	$apache_package	= 'httpd'
	$apache_service = $apache_package
	$apache_user	= 'apache'
	$apache_conf	= '/etc/httpd/conf.d/icingaweb2.conf'
	$groupadd	= 'groupadd -r'
	$webserver_grp	= 'apache'
	$ido_perm	= 'icinga'	
	$mysql_client	= 'mysql'
	$update		= 'chkconfig httpd on'
	$icinga2cli	= 'icingacli'

}

  'Debian', 'Ubuntu': {

	$ntp_service = 'ntp'
	$ssh_service = 'ssh'
	$mysql_service  = 'mysql'
	$apache_package = 'apache2'
	$apache_service = $apache_package
	$apache_user	= 'www-data'
	$apache_conf	= '/etc/apache2/conf-available/icingaweb2.conf'
	$groupadd	= 'addgroup --system'
	$webserver_grp	= 'nagios'
	$ido_perm	= 'nagios'
	$update 	= 'update-rc.d apache2 defaults'
	$mysql_client	= 'mysql-client'
	$icinga2cli = undef
 	}



  default: {
          notify {"THIS MODULE IS ONLY VALID FOR CENTOS 6,7 | RHEL 6,7 |  UBUNTU 14,15 | DEBIAN 8 ONLY":}
          }
    }
}
