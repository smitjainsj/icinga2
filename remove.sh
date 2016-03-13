#!/bin/bash

echo -e  "Remove Icinga2"
for i in ` rpm -qa | grep -i icinga`
do
yum remove -y $i
done

rm -rf /etc/icinga*

