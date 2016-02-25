class icinga2::git inherits icinga2::params
{

vcsrepo { '/opt/icingaweb2':
  ensure   => present,
  provider => git,
  source   => 'git://git.icinga.org/icingaweb2.git',
	}
}
