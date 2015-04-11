# HackFSM Team 8 deployment container
FROM ubuntu:14.04
MAINTAINER Steve Masover "masover@berkeley.edu"

RUN apt-get update

RUN apt-get -y install curl
RUN apt-get -y install wget

RUN apt-get -y install debconf-utils
RUN apt-get -y install libmysqlclient-dev
RUN apt-get -y install git
#
# cf. http://serverfault.com/questions/407317/passing-default-answers-to-apt-get-package-install-questions
#
# generate a pseudo-random password and write it to a file that is then
#  given permissions of 600
#
RUN mkdir /var/tmp/secrets
RUN echo `{ date +%s%N; whoami; } | sed -e 'N;s/\n/ /' | sha256sum | base64 | head -c8;` > /var/tmp/secrets/mysql-secret.txt
RUN chmod 600 /var/tmp/secrets/mysql-secret.txt
#
# install MySQL
#
RUN echo "mysql-server-5.5 mysql-server/root_password_again password `cat /var/tmp/secrets/mysql-secret.txt`" | debconf-set-selections
RUN echo "mysql-server-5.5 mysql-server/root_password password `cat /var/tmp/secrets/mysql-secret.txt`" | debconf-set-selections
RUN apt-get -y install mysql-server
#
# in manually run script, MySQL is started here. This is pointless, tho, because
#  Docker is still building an image and the start won't live beyond the current
#  intermediate container ... so:
#
# DO THIS LATER #############################################
#
# RUN /etc/init.d/mysql start
#
# set up rvm for Ruby and gem management
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
RUN \curl -sSL https://get.rvm.io | bash -s stable
RUN usermod -a -G rvm root
#
# set shell env variables required for rvm and gem bundle install
#
ENV PATH /usr/local/rvm/gems/ruby-2.2.0/bin:/usr/local/rvm/gems/ruby-2.2.0@global/bin:/usr/local/rvm/rubies/ruby-2.2.0/bin:/usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV GEM_PATH /usr/local/rvm/gems/ruby-2.2.0:/usr/local/rvm/gems/ruby-2.2.0@global
#
# install rvm, ruby, gem bundle
#
RUN rvm install 2.2.0
RUN gem install bundle
#
# clone app from GitHub to a folder on the container
# 
RUN cd /var/tmp; git clone https://github.com/jasonk47/hackfsm.git
#
# because Rails doesn't like a bundle install to be perfomed as root,
#  create another user to run the app
#
RUN useradd -p $(openssl passwd -1 "$p") apprunnr && adduser apprunnr rvm
#
# new user to own directory in which app has been cloned
#
RUN cd /var/tmp; chown -R apprunnr hackfsm
#
# run bundle install as new, non-root user
#
RUN su apprunnr && cd /var/tmp/hackfsm && bundle install
#
#
# next step is to append a space plus the content of 
#  /var/tmp/secrets/mysql-secret.txt at the end
#  of each line of config/database.yml that contains:
#
#             password:
#
# will do this with a script in /var/tmp/scripts/db-secret-substitution.sh
# 
# ADD a scripts dir containing said script to the Docker container
# RUN chmod +x ...
# RUN sh /var/tmp/scripts/db-secret-substitution.sh
#
# or something like that





