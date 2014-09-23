FROM ubuntu:14.04

RUN sudo apt-get install -y wget
RUN wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
RUN echo "deb http://pkg.jenkins-ci.org/debian binary/" | sudo tee -a /etc/apt/sources.list
RUN sudo apt-get update
RUN sudo apt-get install -y jenkins
