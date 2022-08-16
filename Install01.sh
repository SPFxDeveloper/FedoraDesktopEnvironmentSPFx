#! /bin/bash

#FEDORA - SPFX

#Antes de ejecutar el siguiente archivo deberá dar los permisos necesarios al mismo desde una terminal

#Si requieres dar permisos de ejecución del script al usuario actual
#sudo chmod 775 Install01.sh

#Si requieres dar permisos de ejecución del script a todos los usuarios
#sudo chmod 777 Install01.sh

#Ejecución del archivo
#sh ./Install01.sh

#/*Remover aplicaciones que no se ocuparán*/
read -t 1 -p "Remove apps ..."
sudo dnf remove -y enki falkon transmission-qt

read -t 5 -p "I am going to wait for 5 seconds only ..."

#/*Limpia paquetes de que no se usan*/
read -t 1 -p "Clean packages ..."
sudo dnf clean packages

read -t 5 -p "I am going to wait for 5 seconds only ..."

#/*Instala Updates SO*/ (Hacerlo desde una terminal cada 3 dias o una vez a la semana por lo menos)
read -t 1 -p "Update OS ..."
sudo dnf update -y && sudo dnf upgrade -y && sudo dnf clean all

read -t 5 -p "I am going to reboot in 5 seconds ..."

sudo reboot
