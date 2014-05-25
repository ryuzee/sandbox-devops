FROM ubuntu:12.04
MAINTAINER ryuzee@gmail.com

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y openssh-server apache2 supervisor
RUN mkdir -p /var/run/sshd
RUN mkdir -p /var/log/supervisor
RUN mkdir -p /var/lock/apache2
VOLUME ./logs
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN echo 'root:root' |chpasswd
EXPOSE 22 80
CMD ["/usr/bin/supervisord"]
