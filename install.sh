#!/bin/bash

USERHOME=$HOME

sudo dnf update -y

#fonts
fontdir="$USERHOME/.local/share/fonts/"
mkdir -p $fontdir && cp -r ./home/.local/share/fonts/* $fontdir

# cinnamond desktop configuration
cp -r ./home/.cinnamon $USERHOME
cp -r ./home/.config/* $USERHOME/.config/
cp -r ./home/.themes/* $USERHOME/.themes/
sudo cp ./cinnamon.css /usr/share/themes/Mint-Y-Dark/cinnamon/cinnamon.css
dconf load / < my-cinnamon.dconf

#gitconfig
cp ./home/.gitconfig $USERHOME

# my programs
cp -r ./home/myPrograms $USERHOME

# services
sudo cp ./services/kmonad.service /etc/systemd/system/kmonad.service
sudo systemctl enable kmonad.service
sudo systemctl start kmonad.service

# rpm fusion
sudo dnf -y install dnf-plugins-core
sudo dnf install -y \
https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo 
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
# rpm fusion vscode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

# install programs
sudo dnf install -y openh264 git code flatpak steam
sudo flatpak install flathub flatseal telegram discord zoom
