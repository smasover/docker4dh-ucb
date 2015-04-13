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
# set up rvm for Ruby and gem management
#
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
# append mysql password contained in /var/tmp/secrets/mysql-secret.txt
#  to the end of each line of config/database.yml that contains the token
#  "password:" -- using a shell script copied into the Docker container
# 
ADD scripts/* /var/tmp/scripts/
RUN chmod +x /var/tmp/scripts/*.sh
RUN sh /var/tmp/scripts/db-secret-substitution.sh
#
# set up app (create and load db)
#
WORKDIR /var/tmp/hackfsm
RUN /etc/init.d/mysql start && rake db:create db:schema:load db:seed
#
##########
# WARNING: success of this step presupposes that app_info.dat has been
#          modified on the host to include valid app-id and app-key for
#          the API on which the Rails app being installed relies; this
#          key is not and should not be committed to any repository!!
##########
#
ADD config/app_info.dat /var/tmp/hackfsm/
RUN grep REPLACE_ /var/tmp/hackfsm/app_info.dat && echo "===FAIL=== It is necessary to replace the contents of app_info.dat with valid appid and appkey on the host where this Dockerfile is run. DO NOT COMMIT these values to a code repository! ===FAIL===" || echo "Assuming appid and appkey are valid, we're in business!"
#
#
#
EXPOSE 3000
CMD /etc/init.d/mysql start && rails s
#
# tested, crudely, with:
#  docker run -i -t -p 3000:3000 056c19067a35
#
# then in a separate terminal window:
#
#  wget localhost:3000
#
#
###################################################
#
# TBD: a better startup, preferably as apprunnr; likely best solution
#      will be a shell script that runs as root to start MySQL, then
#      runs rails as apprunnr
###################################################
#











