#! /bin/bash

## Updating the system

sleep 3

sudo dnf update -y && sudo dnf install figlet -y

sleep 1

## Installing Starship
figlet "Installing Starship" | sed 's/^/\x1b[36m/' ; echo -e "\x1b[0m"

sleep 3
sudo dnf install fish fastfetch -y
sleep 4
curl -sS https://starship.rs/install.sh | sh

sleep 1

## Installing Terminal config

figlet "Installing shell configuration" | sed 's/^/\x1b[36m/' ; echo -e "\x1b[0m"

sleep 3

mkdir -p ~/.config

cp -r * ~/.config

sudo mkdir -p /root/.config/
sudo cp -r * /root/.config/

chsh -s /bin/fish

sleep 3

sudo chsh -s /bin/fish
sleep 1


## Installing Fonts

figlet "Installing Fonts" | sed 's/^/\x1b[36m/' ; echo -e "\x1b[0m"

sleep 3


cd ~/laxmikant-terminal/fonts/
sleep 1
sudo cp -r * /usr/share/fonts
sudo fc-cache -fv
sleep 2

## Theming the bootloader

figlet "Themeing Bootloader" | sed 's/^/\x1b[36m/' ; echo -e "\x1b[0m"

git clone https://github.com/ChrisTitusTech/Top-5-Bootloader-Themes
cd Top-5-Bootloader-Themes
sudo ./install.sh

sleep 5

sudo grub2-mkconfig -o /boot/grub2/grub.cfg

## Installing the DE 

figlet "Installing GNOME DE" | sed 's/^/\x1b[36m/' ; echo -e "\x1b[0m"

sudo dnf group install gnome-desktop
sudo systemctl set-default graphical.target
sudo systemctl enable gdm

## Rebooting the System

figlet "Rebooting" | sed 's/^/\x1b[36m/' ; echo -e "\x1b[0m"

sleep 10
sudo reboot
