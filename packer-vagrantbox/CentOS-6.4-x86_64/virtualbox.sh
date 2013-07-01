#!/bin/bash

sudo sh -c 'echo "[epel]" >> /etc/yum.repos.d/epel.repo'
sudo sh -c 'echo "name=epel" >> /etc/yum.repos.d/epel.repo'
sudo sh -c 'echo "baseurl=http://download.fedoraproject.org/pub/epel/6/\$basearch" >> /etc/yum.repos.d/epel.repo'
sudo sh -c 'echo "enabled=0" >> /etc/yum.repos.d/epel.repo'
sudo sh -c 'echo "gpgcheck=0" >> /etc/yum.repos.d/epel.repo'

sudo yum -y install gcc make automake autoconf libtool gcc-c++ kernel-headers-`uname -r` kernel-devel-`uname -r` zlib-devel openssl-devel readline-devel sqlite-devel perl wget nfs-utils bind-utils

sudo yum -y --enablerepo=epel install dkms

sudo yum -y upgrade

# Installing vagrant keys
mkdir -pm 700 /home/vagrant/.ssh
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant /home/vagrant/.ssh

cd /tmp
sudo mount -o loop /home/vagrant/VBoxGuestAdditions.iso /mnt
sudo sh /mnt/VBoxLinuxAdditions.run
sudo umount /mnt
#rm -rf /home/vagrant/VBoxGuestAdditions*.iso

sudo /etc/rc.d/init.d/vboxadd setup
