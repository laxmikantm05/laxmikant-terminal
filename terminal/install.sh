#! /bin/bash


echo "Updating the System"
sleep 3

sudo dnf update

sleep 1

echo "Installing Starship"
sleep 3

curl -sS https://starship.rs/install.sh | sh

sleep 1

echo "Installing Shell and Fastfetch"
sleep 3

sudo dnf install fish fastfetch

mkdir ~/.config

cp -r * ~/.config

sudo mkdir /root/.config/
sudo cp -r * /root/.config/

chsh -s /bin/fish

sleep 3

sudo chsh -s /bin/fish
sleep 1

echo "Installing the Fonts"
sleep 3
cd ..
sleep 1
cd fonts/
sleep 1
sudo cp -r * /usr/share/fonts

echo "Voila !! your terminal has been set up and your fonts have been installed. Go ahead and re-login..."
