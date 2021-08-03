#Carl Shelton
#email: cmshelton2021@protonmail.com
# date 7/29/2021
echo "Welcome to ScadaLTS installer!"
sleep 2
apt-get update
echo "Installing Tomcat"
sleep 2

apt install -y tomcat9 

echo "Installing Default Jdk"
sleep 2
#install java 11
apt install -y default-jdk
 
echo "Install MariaDB Server"
sleep 2
# MySQL/MariaDB
apt install -y mariadb-server

# MySQL connector
apt install -y libmariadb-java

apt install -y librxtx-java

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
 
echo "Creating scadalts database..."
sleep 2 
sudo mysql -e "create user 'scadalts' identified by 'scadalts'"
sudo mysql -e "create database if not exists scadalts"
sudo mysql -e "grant all privileges on scadalts.* to 'scadalts'"
sudo mysql -e "flush privileges"


echo "Installing Scada-LTC "
sleep 2

mkdir -p /var/lib/tomcat9/webapps/ScadaBR

unzip ScadaBR.war -d //var/lib/tomcat9/webapps/ScadaBR/webapps/ScadaBR
sudo rm //var/lib/tomcat9/webapps/ScadaBR/webapps/ScadaBR/WEB-INF/classes/env.properties
cp env.properties //var/lib/tomcat9/webapps/ScadaBR/webapps/ScadaBR/WEB-INF/classes/

sleep 2


echo "Removing install folder"
 
sudo rm -rf ScadaLTS_RPI_Installer

echo "Removing ScadaBR.war file"

echo "ScadaLTS Install Complete!"


