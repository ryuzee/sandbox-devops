What's this?
============

This helps you creating CentOS box for vagrant-lxc.

How to use
============

First, you should get lxc-template for CentOS as follows.

`
sudo wget -O /usr/lib/lxc/templates/lxc-centos https://gist.github.com/hagix9/3514296/raw/7f6bb4e291fad1dad59a49a5c02f78642bb99a45/lxc-centos
`

and add executable permission
`
chmod 755 /usr/lib/lxc/templates/lxc-centos
`

This script uses some packages so that install packages as follows.
`
sudo apt-get install yum curl wget
`

and finally, you can run the script as follows
`
sudo sh ./build-centos-box.sh
`
