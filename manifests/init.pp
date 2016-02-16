class icinga2 {
	include repo
	include mysql
	include icinga
	include icinga2web
	include files
#	include git_repo

Class["icinga2::repo"] -> Class["icinga2::mysql"] -> Class["icinga2::icinga"] 

}



