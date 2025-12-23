#! /bin/bash


echo " _   _           _       _   _               _   _
| | | |_ __   __| | __ _| |_(_)_ __   __ _  | |_| |__   ___
| | | | '_ \ / _` |/ _` | __| | '_ \ / _` | | __| '_ \ / _ \
| |_| | |_) | (_| | (_| | |_| | | | | (_| | | |_| | | |  __/
 \___/| .__/ \__,_|\__,_|\__|_|_| |_|\__, |  \__|_| |_|\___|
      |_|                            |___/
               _
 ___ _   _ ___| |_ ___ _ __ ___
/ __| | | / __| __/ _ \ '_ ` _ \
\__ \ |_| \__ \ ||  __/ | | | | |
|___/\__, |___/\__\___|_| |_| |_|
     |___/"
sleep 3

sudo dnf update -y

sleep 1

echo " ___           _        _ _ _
|_ _|_ __  ___| |_ __ _| | (_)_ __   __ _
 | || '_ \/ __| __/ _` | | | | '_ \ / _` |
 | || | | \__ \ || (_| | | | | | | | (_| |
|___|_| |_|___/\__\__,_|_|_|_|_| |_|\__, |
                                    |___/
 ____  _                 _     _
/ ___|| |_ __ _ _ __ ___| |__ (_)_ __
\___ \| __/ _` | '__/ __| '_ \| | '_ \
 ___) | || (_| | |  \__ \ | | | | |_) |
|____/ \__\__,_|_|  |___/_| |_|_| .__/
                                |_|"
sleep 3

curl -sS https://starship.rs/install.sh | sh

sleep 1

sleep 3

sudo dnf install fish fastfetch -y

mkdir ~/.config

cp -r * ~/.config

sudo mkdir /root/.config/
sudo cp -r * /root/.config/

chsh -s /bin/fish

sleep 3

sudo chsh -s /bin/fish
sleep 1

echo " ___           _        _ _ _               _____           _
|_ _|_ __  ___| |_ __ _| | (_)_ __   __ _  |  ___|__  _ __ | |_ ___
 | || '_ \/ __| __/ _` | | | | '_ \ / _` | | |_ / _ \| '_ \| __/ __|
 | || | | \__ \ || (_| | | | | | | | (_| | |  _| (_) | | | | |_\__ \
|___|_| |_|___/\__\__,_|_|_|_|_| |_|\__, | |_|  \___/|_| |_|\__|___/
                                    |___/"
sleep 3
cd ..
sleep 1
cd fonts/
sleep 1
sudo cp -r * /usr/share/fonts

echo "Installing Bootloader Theme..."
git clone https://github.com/ChrisTitusTech/Top-5-Bootloader-Themes
cd Top-5-Bootloader-Themes
sudo ./install.sh

sudo dnf group install gnome-desktop
sudo systemctl set-default graphical.target
sudo systemctl enable gdm

echo " ____      _                 _   _
|  _ \ ___| |__   ___   ___ | |_(_)_ __   __ _
| |_) / _ \ '_ \ / _ \ / _ \| __| | '_ \ / _` |
|  _ <  __/ |_) | (_) | (_) | |_| | | | | (_| |_ _ _
|_| \_\___|_.__/ \___/ \___/ \__|_|_| |_|\__, (_|_|_)
                                         |___/"


sleep 10
reboot
