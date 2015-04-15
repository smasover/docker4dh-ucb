This directory contains files that deploy the HackFSM Team #8 (2nd place winner) in a Docker container.

## Steps to set up a Linode (or other server/VM to host Docker containers)

See `README.md` in directory above this one.


## Steps to instantiate a Docker container for HackFSM Team #8 app (Rails)

### Check out this project to local filesystem, e.g., `/var/tmp/`

  ```
  cd /var/tmp
  git clone https://github.com/smasover/docker4dh-ucb
  ```
  
### Modify credentials file

Modify the file `/var/tmp/docker4dh-ucb/hackfsm8/config/app_info.dat` to include valid appid and appkey. The first line is the appid, second line is appkey. Just the values, not a key-value pair. Example:

  ```
  12345678
  0123456789abcdef0123456789abcdef
  ```
  
* Run the Dockerfile

## Starting Docker to test

### Crude test from the container's host (terminal window):

  ```
  docker run -i -t -p 3000:3000 <CONTAINER_ID>
  wget localhost:3000
  ```

## Setting up redirection from host to Docker-exposed port

(fill in this blank)


