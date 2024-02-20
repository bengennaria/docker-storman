# bengennaria/docker-storman -- originally fish2/docker-storman

**Purpose**

Container running the Adaptec Maxview Storage Manager application and the necessary daemons.

With this container, you can manage an Adaptec RAID adapter on the docker host. It is based on Ubuntu from phusion/baseimage and Adaptec MSM

It should be run with --privileged, in order to have access to the hardware and insert the necessary kernel modules.

**Create Command**

Listening on port 8443 tcp (user=root, password=docker):

	docker create --name=storman --hostname=storman --privileged -v /path/to/appdata/config:/usr/StorMan/config -v /path/to/appdata/logs:/usr/StorMan/logs -p 8443:8443/tcp bengennaria/docker-storman

**Build with Custom Password**

Build first edditing the password arg

	docker build https://raw.githubusercontent.com/Fish2/docker-storman/master/Dockerfile -t fish2/docker-storman --build-arg password={your password here}
