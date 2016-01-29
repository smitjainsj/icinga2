class icinga2::git_repo 
{

vcsrepo { '/opt/icingaweb2':
  ensure   => present,
  provider => git,
  source   => 'git://git.icinga.org/icingaweb2.git',
	}
}
