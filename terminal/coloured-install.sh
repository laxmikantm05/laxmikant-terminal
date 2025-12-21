#!/bin/bash

# Define the red_echo function so the script can use it
# \033[31m is the code for Red; \033[0m resets it to normal
red_echo() {
    echo -e "\033[31m$1\033[0m"
}

red_echo "Updating the System"
sudo dnf update -y

sleep 1

red_echo "Installing Starship"
curl -sS starship.rs/install.sh | sh

sleep 1

red_echo "Installing Shell and Fastfetch"
sudo dnf install fish fastfetch -y

# Setup configurations
mkdir -p ~/.config
cp -r * ~/.config/

sudo mkdir -p /root/.config/
sudo cp -r * /root/.config/

red_echo "Changing default shell to Fish..."
chsh -s /bin/fish
sudo chsh -s /bin/fish

sleep 1

red_echo "Installing the Fonts"
# Checks if the fonts directory exists before trying to copy
if [ -d "../fonts" ]; then
    sudo cp -r ../fonts/* /usr/share/fonts/
    fc-cache -f -v
else
    red_echo "Warning: Font directory not found at ../fonts"
fi

echo "Voila !! your terminal has been set up and your fonts have been installed. Go ahead and re-login..."
