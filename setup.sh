#!/bin/sh
#Check that the user has input a non-root user
if [ -z "$1" ]; then
	echo "You must specify a non-root user.  This user will run docker commands without having to run as root";
	exit;
elif [ "$1" == "root" ]; then
	echo "You must specify a non-root user.  Please try again";
	exit;
else
	echo "$1 will be able to run docker commands as root"
fi

sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

if [ -e "/etc/apt/sources.list.d/docker.list" ]; then
        rm /etc/apt/sources.list.d/docker.list;
fi
echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" > /etc/apt/sources.list.d/docker.list

sudo apt-get update
sudo apt-get purge lxc-docker
echo "Checking if it's pulling correctly"
apt-cache policy docker-engine

sudo apt-get update
sudo apt-get install -y linux-image-extra-$(uname -r)
apt-get install apparmor

sudo apt-get update
sudo apt-get install -y docker-engine
sudo service docker start

sudo groupadd docker
sudo usermod -aG docker ubuntu

echo "~~~~~~~~~~~~  SUCCESS! ~~~~~~~~~"
echo "You have successfully installed docker using this script"
echo "You must now log out of the VM and log back in order to have the changes take place for your user...otherwise you cannot run docker!!!"

