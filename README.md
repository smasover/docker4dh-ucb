# Overview

![Digital Humanities Project Hosting using container-based multi-tenancy architecture](docs/DH-Project_ContainerizedMultitenancyArchitecture.png?raw=true "DH Project Hosting: container-based multi-tenancy architecture diagram")

# Installation recipe for host server

This directory contains files that enable deployment of various (Digital Humanities related) applications in Docker containers. This `README.md` file describes steps to set up a Linode (or other server/VM) to host those Docker containers.

Please execute these steps in the order given.

## Optional

### Install Webmin

Visit (http://www.webmin.com/deb.html) to assure that the commands below refer to the latest available version of Webmin. MD5 checksums are available on the [Webmin downloads](http://www.webmin.com/download.html) page.

  ```
  $ cd /var/tmp
  $ mkdir webmin
  $ cd webmin
  $ wget http://prdownloads.sourceforge.net/webadmin/webmin_1.740_all.deb
  $ apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python
  $ dpkg --install webmin_1.740_all.deb
  ```

## Required

### Configure Linux firewall

* Use webmin (Networking : Linux Firewall)
* Choose `Allow all` traffic
* Click `Setup Firewall`
* now go to the `/etc` dir and look for `/etc/iptables.up.rules`
* copy the original (Allow All) version of file to: `iptables.up.rules.ALLOW-ALL`
* update the content of the file to the content of the file `config/iptables.up.rules_base` in this project
* after applying the firewall and testing that desired traffic is permitted (minimally, SSH via port 22 and Webmin via port 10000), set the firewall to `Activate at boot`
* for reference, see the screenshot below:

![Linux Firewall configuration on Webmin interface](docs/LinuxFirewall_WebminScreenshot.png?raw=true "Linux Firewall configuration on Webmin interface")

### Install Apache httpd

(describe here)

### Install Docker

These instructions (for installing then testing the Docker installation) are cribbed from [docs.docker.com](https://docs.docker.com/installation/ubuntulinux/). They assume that `wget` is already installed.

  ```
  $ wget -qO- https://get.docker.com/ | sh
  $ docker run hello-world
  ```

### Install Git (if not already installed)

  ```
  $ apt-get install git
  ```



