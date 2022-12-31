#!/bin/bash

USERHOME=$HOME
WORKDIR=$(pwd)

sudo dnf update -y

#fonts
fontdir="$USERHOME/.local/share/fonts/"
mkdir -p $fontdir && cp -r home/.local/share/fonts/* $fontdir

# cinnamond desktop configuration
cp -r home/.cinnamon $USERHOME
cp -r home/.config/* $USERHOME/.config/
cp -r home/.themes/* $USERHOME/.themes/
dconf load / < my-cinnamon.dconf

#dotfiles
cp home/.gitconfig home/.bashrc home/.tmux.conf $USERHOME

# my programs
cp -r home/myPrograms $USERHOME

# services
sudo cp services/kmonad.service /etc/systemd/system/kmonad.service
sudo systemctl enable kmonad.service
sudo systemctl start kmonad.service

# nemo actions
cd /usr/share/nemo/actions
sudo rm add-desklets.nemo_action change-background.nemo_action new-launcher.nemo_action
cd $WORKDIR
cp home/.local/share/nemo/actions/vscode.nemo_action $USERHOME/.local/share/nemo/actions/

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
