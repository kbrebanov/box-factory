#!/bin/ash

# Add vagrant user and group
/usr/sbin/addgroup vagrant
/usr/sbin/adduser -h /home/vagrant -s /bin/ash -G vagrant -D vagrant
/bin/echo vagrant:vagrant | /usr/sbin/chpasswd

# Install sudo and openssl packages
/sbin/apk add sudo openssl

# Configure password-less sudo for vagrant user
/bin/cat > /etc/sudoers.d/vagrant <<EOF
vagrant ALL=(ALL) NOPASSWD: ALL
EOF
/bin/chmod 0440 /etc/sudoers.d/vagrant

# Configure Vagrant public SSH key for vagrant user
/bin/mkdir /home/vagrant/.ssh
/usr/bin/wget -O /home/vagrant/.ssh/authorized_keys https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub
/bin/chmod 0600 /home/vagrant/.ssh/authorized_keys
/bin/chmod 0700 /home/vagrant/.ssh
/bin/chown -R vagrant:vagrant /home/vagrant/.ssh

# Configure SSH
/bin/sed -i 's/^#UseDNS[[:space:]]no$/UseDNS no/' /etc/ssh/sshd_config
/bin/sed -i 's/^PermitRootLogin[[:space:]]yes$/#PermitRootLogin yes/' /etc/ssh/sshd_config
