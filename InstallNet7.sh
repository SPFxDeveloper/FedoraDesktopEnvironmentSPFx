#! /bin/bash

#FEDORA - DotNet
#https://dotnetcli.azureedge.net/dotnet/Sdk/7.0.100/dotnet-sdk-7.0.100-linux-x64.tar.gz
#Antes de ejecutar el siguiente archivo deberá dar los permisos necesarios al mismo desde una terminal

#Si requieres dar permisos de ejecución del script al usuario actual
#sudo chmod 775 InstallNet7.sh

#Si requieres dar permisos de ejecución del script a todos los usuarios
#sudo chmod 777 InstallNet7.sh

#Ejecución del archivo
#sh ./InstallNet7.sh

read -t 1 -p "Download and permissions dotnet file ...`echo $'\n> '`"
cd ~ && cd Downloads/
wget https://dot.net/v1/dotnet-install.sh
sudo chmod +x ./dotnet-install.sh

read -t 1 -p "Install dotnet 7 ...`echo $'\n> '`"
sudo ./dotnet-install.sh --channel 7.0 -InstallDir /usr/lib64/dotnet/

read -t 1 -p "Update bash file vars ...`echo $'\n> '`"
echo 'export DOTNET_ROOT=/usr/lib64/dotnet/.dotnet' >> ~/.bashrc
echo 'export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools' >> ~/.bashrc

source ~/.bashrc

dotnet --list-sdks
dotnet --list-runtimes

read -t 1 -p "Delete bash file ...`echo $'\n> '`"
rm -rf dotnet-install.sh
