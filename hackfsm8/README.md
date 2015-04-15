This directory contains files that deploy the HackFSM Team #8 (2nd place winner) in a Docker container.

## Steps to set up a Linode (or other server/VM to host Docker containers)

### Optional

* Install Webmin

### Required

* Configure Linux firewall
* Install Apache httpd
* Install Docker
  * `sh -c "echo deb https://get.docker.com/ubuntu docker main > /etc/apt/sources.list.d/docker.list"`
  * `apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9`
  * `apt-get update`
  * `apt-get install lxc-docker`
* Install Git (if not already installed)
  * `apt-get install git`


## Steps to instantiate a Docker container for HackFSM Team #8 app (Rails)

* Check out this project to local filesystem, e.g., `/var/tmp/`
  * `cd /var/tmp`
  * `git clone https://github.com/smasover/docker4dh-ucb`
* Modify the file `/var/tmp/docker4dh-ucb/hackfsm8/config/app_info.dat` to include valid appid and appkey
* Run the Dockerfile

## Starting Docker to test

* Crude test from the container's host (terminal window):
  * `docker run -i -t -p 3000:3000 <CONTAINER_ID>`
  * `wget localhost:3000`

## Setting up redirection from host to Docker-exposed port

(fill in this blank)


