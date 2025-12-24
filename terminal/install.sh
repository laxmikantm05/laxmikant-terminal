#! /bin/bash

## Updating the system

sleep 3

sudo dnf update -y

sleep 1

## Installing Starship


sleep 3

curl -sS https://starship.rs/install.sh | sh

sleep 1

## Installing Terminal config


sleep 3

sudo dnf install fish fastfetch -y

mkdir -p ~/.config

cp -r * ~/.config

sudo mkdir -p /root/.config/
sudo cp -r * /root/.config/

chsh -s /bin/fish

sleep 3

sudo chsh -s /bin/fish
sleep 1


## Installing Fonts



sleep 3


cd ~/laxmikant-terminal/fonts/
sleep 1
sudo cp -r * /usr/share/fonts
sudo fc-cache -fv
sleep 2

## Theming the bootloader


git clone https://github.com/ChrisTitusTech/Top-5-Bootloader-Themes
cd Top-5-Bootloader-Themes
sudo ./install.sh

## Installing the DE 

sudo dnf group install gnome-desktop
sudo systemctl set-default graphical.target
sudo systemctl enable gdm

## Rebooting the System


sleep 10
sudo reboot
