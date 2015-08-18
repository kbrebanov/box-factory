#!/bin/bash

apt-get -y autoremove
apt-get -y autoclean
apt-get -y clean
rm -rf VBoxGuestAdditions_*.iso VBoxGuestAdditions_*.iso.?
rm -f /tmp/chef*deb
