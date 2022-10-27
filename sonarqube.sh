#!/bin/bash

#Author: Armel Tamwa Kouam
#Date: October 27 2022

#-------------Installation of sonarqube in centOS 7------------------#
if [${USER}] == root]
then
echo "Installation doesn't work as root user. Need to be regular user!"
exit 3
fi

#step 1: Java 11 installation
sudo yum update -y
sudo yum install java-11-openjdk-devel -y
sudo yum install java-11-openjdk -y

#step 2: Sonarqube latest versions download on the server
cd /opt

sudo yum install wget -y
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.3.0.51899.zip

#step 3: Packages extraction
sudo yum install unzip -y

sudo unzip /opt/sonarqube-9.3.0.51899.zip

#step 4: Changing the ownership to the user and switching to Linux binaries directory to start service
sudo chown -R vagrant:vagrant /opt/sonarqube-9.3.0.51899
cd /opt/sonarqube-9.3.0.51899/bin/linux-x86-64 
 ./sonar.sh start

#Starting the firewalld if not started
sudo systemctl start firewalld

#enabling the port 9000 used by sonarqube
sudo firewall-cmd --permanent --add-port=9000/tcp
sudo friewall-cmd --reload

echo "Installation done successfully. Please get the ip address and access your sonarqube on the browser!"
