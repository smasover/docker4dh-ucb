# Overview

![Digital Humanities Project Hosting using container-based multi-tenancy architecture](docs/DH-Project_ContainerizedMultitenancyArchitecture.png?raw=true "DH Project Hosting: container-based multi-tenancy architecture diagram")

# Installation recipe for host server

This directory contains files that enable deployment of various (Digital Humanities related) applications in Docker containers. This `README.md` file describes steps to set up a Linode (or other server/VM) to host those Docker containers.

## Optional

* Install Webmin

## Required

### Configure Linux firewall

(describe here)

### Install Apache httpd

(describe here)

### Install Docker

  ```
  sh -c "echo deb https://get.docker.com/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
  apt-get update
  apt-get install -y lxc-docker
  ```

### Install Git (if not already installed)

  ```
  apt-get install git
  ```



