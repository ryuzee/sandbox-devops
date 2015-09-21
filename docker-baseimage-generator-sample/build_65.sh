#!/bin/sh
export CENTOS_BUILD_VERSION="6.5"

vagrant up --provision

cd export
cat centos-$CENTOS_BUILD_VERSION.tar.gz | docker import - local/centos:$CENTOS_BUILD_VERSION
docker run local/centos:$CENTOS_BUILD_VERSION cat /etc/redhat-release
image_id=`docker ps -aq | head -1`
docker commit $image_id ryuzee/centos:$CENTOS_BUILD_VERSION
