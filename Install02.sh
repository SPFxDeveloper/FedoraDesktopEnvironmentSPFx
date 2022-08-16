#! /bin/bash

#FEDORA - SPFX

#Antes de ejecutar el siguiente archivo deberá dar los permisos necesarios al mismo desde una terminal

#Si requieres dar permisos de ejecución del script al usuario actual
#sudo chmod 775 Install02.sh

#Si requieres dar permisos de ejecución del script a todos los usuarios
#sudo chmod 777 Install02.sh

#Ejecución del archivo
#sh ./Install02.sh

#/*Instala repositorios*/
read -t 1 -p "Install repositories and basic applications ..."
sudo dnf install -y fedora-workstation-repositories deepin-icon-theme featherpad elementary-calculator git
#/*Instala el menú inferior para anclar las aplicaciones*/
sudo dnf install -y plank plank-docklets picom
#/*Busca e instala el paquete de .net más reciente*/
sudo dnf search dotnet
sudo dnf install -y dotnet-sdk-6.0
#/*Paquetes para el cambio de pantalla de login*/
sudo dnf install -y lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings

read -t 5 -p "I am going to wait for 5 seconds only ..."

#/*habilita repositorio de google chrome*/
read -t 1 -p "Enable google chrome repository ..."
sudo dnf config-manager --set-enabled google-chrome

read -t 5 -p "I am going to wait for 5 seconds only ..."

#/*Instala google chrome*/
read -t 1 -p "Install google chrome ..."
sudo dnf install -y google-chrome-stable

read -t 5 -p "I am going to wait for 5 seconds only ..."

#/*INSTALA VS Code*/
read -t 1 -p "Install VS Code ..."
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf install -y code

read -t 5 -p "I am going to wait for 5 seconds only ..."

#/*desactiva telemetria .Net*/
read -t 1 -p "Disable .net telemetry ..."
cd ~
echo 'export DOTNET_CLI_TELEMETRY_OPTOUT=1' >> .profile
read -t 5 -p "I am going to wait for 5 seconds only ..."

#/*Configura terminal con GIT*/
read -t 1 -p "Download Git for bash prompt ..."
cd ~
wget https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
read -t 2 -p "I am going to wait for 2 seconds only ..."

#/*configura bash*/
read -t 1 -p "Configure bash prompt ..."
cat >> ~/.bashrc << EOT

if [ -f ~/.git-prompt.sh ]; then
source ~/.git-prompt.sh
fi
PS1='\[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\] @ \w\[\033[0;32m\]\n$(git branch 2>/dev/null | grep "^*" | colrm 1 2)\[\033[0;32m\]└─\[\033[0m\033[0;32m\] \$\[\033[0m\033[0;32m\]\[\033[0m\] '

EOT

read -t 5 -p "I am going to wait for 5 seconds only ..."

#/*Download and install azure data studio*/
read -t 1 -p "Download and install azure data studio ..."
cd ~ && cd Downloads/
wget https://sqlopsbuilds.azureedge.net/stable/dff93c4736269ef2a7e8a225737a0d8354bf0246/azuredatastudio-linux-1.38.0.rpm
sudo dnf install -y ./azuredatastudio-linux-1.38.0.rpm
rm -rf azuredatastudio-linux-1.38.0.rpm

read -t 5 -p "I am going to wait for 5 seconds only ..."

#/*Download and install Insomnia*/
read -t 1 -p "Download and install Insomnia ..."
cd ~ && cd Downloads/
wget https://github.com/Kong/insomnia/releases/download/core%402022.4.2/Insomnia.Core-2022.4.2.rpm
sudo dnf install -y ./Insomnia.Core-2022.4.2.rpm
rm -rf Insomnia.Core-2022.4.2.rpm

read -t 5 -p "I am going to wait for 5 seconds only ..."

#/*Download and install Postman*/
read -t 1 -p "Download and install Postman ..."
cd ~ && cd Downloads/
wget -O postman-linux-x64.tar.gz https://dl.pstmn.io/download/latest/linux64 
tar -xzvf Postman-linux-x86_64-8.11.1.tar.gz
sudo mv Postman /opt
sudo ln -s /opt/Postman/Postman /usr/local/bin/postman
rm -rf postman-linux-x64.tar.gz

cat >> /usr/share/applications/postman.desktop << EOT

[Desktop Entry]
Type=Application
Name=Postman REST Client
Icon=/opt/Postman/app/resources/app/assets/icon.png
Exec="/opt/Postman/Postman"
Comment=Postman REST Client Desktop App
Categories=Development;Code;Testing;

EOT

read -t 5 -p "I am going to wait for 5 seconds only ..."

#/*Download and install Figma*/
read -t 1 -p "Download and install Figma ..."
cd ~ && cd Downloads/
wget https://github.com/Figma-Linux/figma-linux/releases/download/v0.10.0/figma-linux_0.10.0_linux_x86_64.rpm
sudo dnf install -y ./figma-linux_0.10.0_linux_x86_64.rpm
rm -rf figma-linux_0.10.0_linux_x86_64.rpm

read -t 5 -p "I am going to wait for 5 seconds only ..."

#/*Instalación NVM */
read -t 1 -p "Install NVM ..."
cd ~
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
source ~/.bashrc
command -v nvm

read -t 5 -p "I am going to wait for 5 seconds only ..."

#/*VS Code no te marque error cuando tienes un proyecto grande*/
read -t 1 -p "Support long files in VS Code  ..."
sudo sh -c 'echo -e "fs.inotify.max_user_watches=524288" > /etc/sysctl.conf'
sudo sysctl -p

read -t 5 -p "I am going to reboot in 5 seconds ..."

sudo reboot
