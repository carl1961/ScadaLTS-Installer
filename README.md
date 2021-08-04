# WORK IN PROGRESS Running!

- If git does not work? install git
 #### sudo  apt-get install git

## ScadaLTS Installer Installs

   - default-jdk_1.11-71 ...... downloads from internet source
   - apache-tomcat-9.0.50 ..... downloads from internet source
   - mariadb-server_10.3.29-0 . downloads from internet source
   - Scada-LTS 2.5   .......... Latest ScadaLTS as of 8-3-2021
   -    Scada-LTS 2.5 installs to  /var/lib/tomcat9/webapps
- Tested on (RPI3),(RPI 4),(Debian Buster amd64  VirtualBox)  

## ScadaLTS Installation:
- Download the sources 
 

git clone https://github.com/carl1961/ScadaLTS-Installer.git

- Move to install folder

#### cd ScadaLTS-Installer

- Give execute permissions to `install_scadalts.sh`
 
#### sudo chmod +x install_scadalts.sh

- To install ScadaLTS, run the script `install_scadalts.sh` using the command `./install_scadalts.sh`
You may have to answer Y for some installs
#### sudo ./install_scadalts.sh


## Note: 

MariaDB Server, and Scada-LTS Database Auto filled by install_scadalts.sh

To access your Raspberry Pi’s MySQL server and start making changes to your databases, you can enter the following command.

####  sudo mysql -u root -p

 You will be prompted to enter the password 
 
- mariadb-server_10.3.29-0           PSWD/admin
- Scada-LTS 2.5          User/admin  PSWD/admin


#### In web browser type   http://localhost:8080/ScadaBR  or IP address http://xxx.xxx.xxx.xxx:8080/ScadaBR

### https://github.com/SCADA-LTS/Scada-LTS     
### http://scada-lts.org/      
### https://www.facebook.com/ScadaLTS
