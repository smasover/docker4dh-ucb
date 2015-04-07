# HackFSM Team 8 deployment container
FROM ubuntu:14.04
MAINTAINER Steve Masover "masover@berkeley.edu"

RUN apt-get update

RUN apt-get -y install curl
RUN apt-get -y install wget

#
# cf. http://serverfault.com/questions/407317/passing-default-answers-to-apt-get-package-install-questions
#
#
RUN apt-get -y install debconf-utils
#
# generate a pseudo-random password and write it to a file that is then
#  given permissions of 600
#
RUN mkdir /var/tmp/secrets
RUN echo `{ date +%s%N; whoami; } | sed -e 'N;s/\n/ /' | sha256sum | base64 | head -c8;` > /var/tmp/secrets/mysql-secret.txt
RUN chmod 600 /var/tmp/secrets/mysql-secret.txt

RUN echo "mysql-server-5.5 mysql-server/root_password_again password `cat /var/tmp/secrets/mysql-secret.txt`" | debconf-set-selections
RUN echo "mysql-server-5.5 mysql-server/root_password password `cat /var/tmp/secrets/mysql-secret.txt`" | debconf-set-selections
RUN apt-get -y install mysql-server




