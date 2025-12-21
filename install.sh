#! /bin/bash


print "Updating the System"

sudo dnf update

sleep 1

print "Installing Starship"

curl -sS https://starship.rs/install.sh | sh

sleep 1

print "Installing Shell and Fastfetch"

sudo dnf install fish fastfetch

mkdir ~/.config

cp -r * ~/.config

sudo mkdir /root/.config/
sudo cp -r * /root/.config/

chsh -s /bin/fish

sleep 3

sudo chsh -s /bin/fish

print "Voila !! your terminal has been set up. Go ahead and re-login..."
