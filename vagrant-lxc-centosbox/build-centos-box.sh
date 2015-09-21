#!/bin/bash

set -e
NOW=$(date -u -R)
RELEASE=${1:-"6"}
RELEASE_MINOR=${2:-"4"}
ARCH=${3:-"x86_64"}
LXC_NAME=CentOS-${RELEASE}.${RELEASE_MINOR}
PKG=vagrant-lxc-${LXC_NAME}-${ARCH}-ja.box
WORKING_DIR=/tmp/vagrant-lxc-${LXC_NAME}
ROOTFS=/var/lib/lxc/${LXC_NAME}/rootfs

# Path to files bundled with the box
CWD=`readlink -f .`
LXC_TEMPLATE=${CWD}/common/lxc-template
LXC_CONF=${CWD}/common/lxc.conf
METATADA_JSON=${CWD}/common/metadata.json

# Set up a working dir
mkdir -p $WORKING_DIR

if [ -f "${WORKING_DIR}/${PKG}" ]; then
  echo "Found a box on ${WORKING_DIR}/${PKG} already!"
  exit 1
fi

## Create container
if $(lxc-ls | grep -q "${LXC_NAME}"); then
  echo "Base container already exists, please remove it with \`lxc-destroy -n ${LXC_NAME}\`!"
  exit 1
else
  lxc-create -n ${LXC_NAME} -t centos -- --release ${RELEASE}
fi

# Fixes some networking issues
# See https://github.com/fgrehm/vagrant-lxc/issues/91 for more info
echo 'ff02::3 ip6-allhosts' >> ${ROOTFS}/etc/hosts

## Create vagrant user
chroot ${ROOTFS} /usr/sbin/groupadd vagrant
chroot ${ROOTFS} /usr/sbin/useradd vagrant -g vagrant -G wheel
echo -n 'vagrant:vagrant' | chroot ${ROOTFS} chpasswd
mkdir -p ${ROOTFS}/home/vagrant/.ssh
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' \
     -O ${ROOTFS}/home/vagrant/.ssh/authorized_keys
chroot ${ROOTFS} chown -R vagrant: /home/vagrant/.ssh
sed -i "s/#UseDNS yes/UseDNS no/" ${ROOTFS}/etc/ssh/sshd_config

echo "vagrant        ALL=(ALL)       NOPASSWD: ALL" >> ${ROOTFS}/etc/sudoers.d/vagrant
chmod 0440 ${ROOTFS}/etc/sudoers.d/vagrant
sed -i "s/^.*requiretty/#Defaults requiretty/" ${ROOTFS}/etc/sudoers

## Additional packages and update
chroot ${ROOTFS} yum install -y vim curl wget tar
chroot ${ROOTFS} yum upgrade -y

## Japanese Support
chroot ${ROOTFS} yum groupinstall -y "Japanese Support"

echo 'LANG="ja_JP.UTF-8"' > ${ROOTFS}/etc/sysconfig/i18n
echo 'SYSFONT="latarcyrheb-sun16"' >> ${ROOTFS}/etc/sysconfig/i18n

## Installing Chef
chroot ${ROOTFS} curl -L http://www.opscode.com/chef/install.sh | chroot ${ROOTFS} bash

## add TUN/TAP
mkdir -p ${ROOTFS}/dev/net
mknod ${ROOTFS}/dev/net/tun c 10 200
chmod 666 ${ROOTFS}/dev/net/tun

## Clean up on instance
rm -rf ${ROOTFS}/tmp/*
chroot ${ROOTFS} yum clean all

## Building box
# Compress container's rootfs
cd $(dirname $ROOTFS)
tar --numeric-owner -czf $WORKING_DIR/rootfs.tar.gz ./rootfs/*

# Prepare package contents
cd $WORKING_DIR
cp $LXC_TEMPLATE .
cp $LXC_CONF .
cp $METATADA_JSON .
chmod +x lxc-template
sed -i "s/<TODAY>/${NOW}/" metadata.json

# Vagrant box
tar -czf $PKG ./*
chmod +rw ${WORKING_DIR}/${PKG}
mkdir -p ${CWD}/output
mv ${WORKING_DIR}/${PKG} ${CWD}/output

# Cleanup working directory and working instance
cd ${CWD}
rm -rf ${WORKING_DIR}
lxc-destroy -n ${LXC_NAME}

## Ending
echo "The ${PKG} box was built successfully to ${CWD}/output/"
