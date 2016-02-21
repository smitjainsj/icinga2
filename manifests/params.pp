class icinga2::params {


Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/', '/usr/local/bin', ] }

########## MySQL #########
$mysql_package		= 'mysql-server'
$mysql_client		= 'mysql-client'
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
$icinga2cli_cmd		= 'icingacli'
$icinga2web_dbname      = $icinga2web_package
$icinga2web_dbuser      = $icinga2web_dbname
$icinga2web_dbpass	= $icinga2web_dbpass
$icinga2web_pass_hash 	= '$1$RHJ4audO$2ctxm4EeJtzZnHw/JlDPO0'

####### OTHERS #########
$document_root  	= '/usr/share/icingaweb2/public'	
$usermod		= '/usr/sbin/usermod -a -G'
$mysql_icinga2_schema	= '/usr/share/icinga2-ido-mysql/schema/mysql.sql'
$mysql_icinga2web_schema	= '/usr/share/icingaweb2/icingaweb2/etc/schema/mysql.schema.sql'

###### OS BASED ##########

case $::operatingsystem {

  'CentOS','Redhat': {

	$ntp_service    = 'ntpd'
	$ssh_service    = 'sshd'
	$mysql_service  = 'mysqld'
	$apache_package	= 'httpd'
	$apache_service = $apache_package
	$apache_user	= 'apache'
	$apache_conf	= '/etc/httpd/conf.d/icingaweb2.conf'
	$groupadd	= '/usr/sbin/groupadd -r'
	$webserver_grp	= 'nagios'
}

  'Debian', 'Ubuntu': {

	$ntp_service = 'ntp'
	$ssh_service = 'ssh'
	$mysql_service  = 'mysql'
	$apache_package = 'apache2'
	$apache_service = $apache_package
	$apache_user	= 'www-data'
	$apache_conf	= '/etc/apache2/conf-available/icingaweb2.conf'
	$groupadd	= '/usr/sbin/addgroup --system'
	$webserver_grp	= 'nagios'

  	}



  default: {
          notify {"THIS MODULE IS ONLY VALID FOR CENTOS 6,7 | RHEL 6,7 |  UBUNTU 14,15 | DEBIAN 8 ONLY":}
          }
    }
}
