#!/bin/bash

USERHOME=$HOME
WORKDIR=$(pwd)

dnf remove -y libreoffice* mpv parole hexchat pidgin onboard
sudo dnf update -y

#fonts
fontdir="$USERHOME/.local/share/fonts/"
mkdir -p $fontdir && cp -r home/.local/share/fonts/* $fontdir

# cinnamond desktop configuration
cp -r home/.cinnamon $USERHOME
cp -r home/.config/* $USERHOME/.config/
cp -r home/.themes/* $USERHOME/.themes/

# load dconf
echo user-db:user > temporary-profile
DCONF_PROFILE="$(pwd)/temporary-profile" dconf load / < my-cinnamon.dconf

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

# login window config
echo "[Greeter]\
background=/usr/share/backgrounds/tiles/blackscreen\
theme-name=Mint-Y-Dark\
icon-theme-name=Mint-Y-Dark\
" | sudo tee /etc/lightdm/slick-greeter.conf

# set dns
echo "nameserver 1.1.1.1" | sudo tee -a /etc/resolv.conf
echo "nameserver 8.8.8.8" | sudo tee -a /etc/resolv.conf

# firefox
test -n "`find ~/.mozilla/firefox/*.default-release`" && cp home/.mozilla/firefox/.default-release $USERHOME/.mozilla/firefox/*.default-release

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
sudo dnf install -y openh264 htop bat git code steam telegram flatpak
sudo flatpak install -y flathub flatseal discord zoom onlyoffice
