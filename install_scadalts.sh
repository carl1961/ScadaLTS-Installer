#!/bin/bash
#Carl Shelton
#email: cmshelton2021@protonmail.com
# date 7/29/2021
echo -e "Welcome to ScadaLTS installer!"
CURRENT_FOLDER=$(pwd)
INSTALL_FOLDER=/opt/ScadaLTS


echo -e "   * Creating Install Folder..."
mkdir -p  $INSTALL_FOLDER 
cd   ${INSTALL_FOLDER}
cp   ${CURRENT_FOLDER}/ScadaBR.war $INSTALL_FOLDER
cp   ${CURRENT_FOLDER}/env.properties $INSTALL_FOLDER

cd

apt-get update
echo -e "Installing Tomcat"

apt-get  install -y tomcat9  
echo -e "Installing Default Jdk"

#install java 11
apt-get install -y default-jdk
echo -e "Install MariaDB Server"

# MySQL/MariaDB
apt-get install -y mariadb-server
# MySQL connector
apt-get install -y libmariadb-java

sudo apt-get install librxtx-java
sudo systemctl enable mariadb
sudo systemctl start mariadb
root_password=admin
# Make sure that NOBODY can access the server without a password

sudo mysql -e "UPDATE mysql.user SET Password = PASSWORD('$root_password') WHERE User = 'root'"
 
# Kill the anonymous users
sudo mysql -e "DROP USER IF EXISTS ''@'localhost'"
# Because our hostname varies we'll use some Bash magic here.
sudo mysql -e "DROP USER IF EXISTS ''@'$(hostname)'"
# Kill off the demo database
sudo mysql -e "DROP DATABASE IF EXISTS test"
 
echo -e "Creating scadalts database..."

sudo mysql -e "create user 'scadalts' identified by 'scadalts'"
sudo mysql -e "create database if not exists scadalts"
sudo mysql -e "grant all privileges on scadalts.* to 'scadalts'"
sudo mysql -e "flush privileges"



echo -e "   * Extracting ScadaBR into Tomcat..."
mkdir -p /var/lib/tomcat9/webapps/ScadaBR
cd   $INSTALL_FOLDER
unzip ${INSTALL_FOLDER}/ScadaBR.war -d /var/lib/tomcat9/webapps/ScadaBR

sudo rm /var/lib/tomcat9/webapps/ScadaBR/WEB-INF/classes/env.properties

sudo cp ${INSTALL_FOLDER}/env.properties /var/lib/tomcat9/webapps/ScadaBR/WEB-INF/classes/

echo -e " - Starting Tomcat9: /var/lib/tomcat9/bin/startup.sh"
sudo /var/lib/tomcat9/bin/startup.sh

#echo -e "Cleaning Up!"

#echo -e "Removing Install Folder"
sudo rm -rf  $INSTALL_FOLDER 
#echo -e "Removing ScadaLTS-Test Folder"
cd 
sudo rm -rf ScadaLTS-Test
echo -e "ScadaLTS Install Complete!"


