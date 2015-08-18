#!/bin/bash

yum -y clean all
rm -rf VBoxGuestAdditions_*.iso VBoxGuestAdditions_*.iso.?
rm -f /tmp/chef*rpm

# Clean up RedHat interface persistence
rm -f /etc/udev/rules.d/70-persistent-net.rules
# Support CentOS <= 6.x and CentOS >= 7.x interface naming schemes:
# CentOS <= 6.x: eth*
# CentOS >= 7.x: en*
for interface in $(ls /etc/sysconfig/network-scripts/ifcfg-e*)
do
    sed -i 's/^HWADDR.*$//' $interface
    sed -i 's/^UUID.*$//' $interface
done
