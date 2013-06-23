#!/bin/sh

wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
cat /etc/apt/sources.list | grep jenkins
status=$?
if [ ! $status -eq "0" ]; then
    echo "deb http://pkg.jenkins-ci.org/debian binary/" >> /etc/apt/sources.list
fi
sudo apt-get update -y
sudo apt-get install -y jenkins
sudo apt-get install -y curl 
sudo apt-get install -y build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison libmysqlclient-dev libpq-dev

cat /etc/sudoers | grep jenkins
status=$?
if [ ! $status -eq "0" ]; then
    echo "jenkins ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers
fi

sudo ufw allow 8080

sudo -H -u jenkins -s bash -c 'curl -L https://get.rvm.io | bash'
sudo -H -u jenkins -s bash -c 'source /var/lib/jenkins/.rvm/scripts/rvm; rvm install 1.9.3'
sudo -H -u jenkins -s bash -c 'source /var/lib/jenkins/.rvm/scripts/rvm; rvm use 1.9.3 --default' 
