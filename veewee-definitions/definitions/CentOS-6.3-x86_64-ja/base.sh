# Base install

sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

sed -i "s/#UseDNS yes/UseDNS no/" /etc/ssh/sshd_config

# for build rvm

cat > /etc/yum.repos.d/epel.repo << EOM
[epel]
name=epel
baseurl=http://download.fedoraproject.org/pub/epel/6/\$basearch
enabled=0
gpgcheck=0
EOM

yum -y install gcc make automake autoconf libtool gcc-c++ kernel-devel-`uname -r` zlib-devel openssl-devel readline-devel sqlite-devel perl wget nfs-utils bind-utils

yum -y --enablerepo=epel install dkms

yum -y upgrade

