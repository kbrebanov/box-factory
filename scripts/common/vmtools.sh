#!/bin/bash

vbox_tmp_dir="/tmp/vbox"
vmware_tmp_dir="/tmp/vmware"

# Set user
case "${PACKER_BUILD_NAME}" in
    vagrant*) user="vagrant";;
    *) user="usradm";;
esac

# Install packages required for compiling virtual machine tools
case "${PACKER_BUILD_NAME}" in
    *centos*) yum -y install bzip2 gcc kernel-headers kernel-devel make perl;;
    *ubuntu*) apt-get -y install dkms gcc linux-headers-$(uname -r) make perl;;
esac

if [ "${PACKER_BUILDER_TYPE}" == "virtualbox-iso" ]; then
    mkdir ${vbox_tmp_dir}
    version=$(cat /home/${user}/.vbox_version)
    mount -o loop /home/${user}/VBoxGuestAdditions_${version}.iso ${vbox_tmp_dir}
    sh ${vbox_tmp_dir}/VBoxLinuxAdditions.run
    umount ${vbox_tmp_dir}
    rmdir ${vbox_tmp_dir}
    rm /home/${user}/VBoxGuestAdditions_${version}.iso
fi

if [ "${PACKER_BUILDER_TYPE}" == "vmware-iso" ]; then
    mkdir ${vmware_tmp_dir}
    mkdir ${vmware_tmp_dir}-archive
    mount -o loop /home/${user}/linux.iso ${vmware_tmp_dir}
    tar zxf ${vmware_tmp_dir}/VMwareTools-*.tar.gz -C ${vmware_tmp_dir}-archive
    ${vmware_tmp_dir}-archive/vmware-tools-distrib/vmware-install.pl --default
    umount ${vmware_tmp_dir}
    rm -rf ${vmware_tmp_dir}
    rm -rf ${vmware_tmp_dir}-archive
    rm /home/${user}/linux.iso
fi
