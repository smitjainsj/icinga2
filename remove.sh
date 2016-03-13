#!/bin/bash

echo -e  "Remove Icinga2"
for i in ` rpm -qa | egrep -i "icinga|php|httpd|mysql-server|mysql" `
do
yum remove -y $i
done

rm -rf /etc/icinga* /var/log/icinga* /var/lib/mysql* /var/log/php* /var/log/mysql* /etc/httpd*

