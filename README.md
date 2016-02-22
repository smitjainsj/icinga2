###################################################################

This Module Works for Ubuntu 14.x & 15.x

This module is depends upon VCSREPO Module. Use the below command to download the module.

$puppet module install puppetlabs-vcsrepo

This will install Icinga2 core with Icingaweb2 Interface and MySQL as a backend.

For web login : http://yourhostip/icingaweb2

Credentials : icingaadmin/icingaadmin

Do update the hash code in params.pp before running the module . Use the below command to generate the HASH for the password.

$openssl passwd -1 icingaadmin

