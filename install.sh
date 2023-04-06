#!/bin/bash

USERHOME=$HOME
WORKDIR=$(pwd)

sudo dnf remove -y dnfdragora libreoffice* thunderbird mpv parole hexchat pidgin onboard xawtv xfburn
sudo dnf update -y

#fonts
fontdir="$USERHOME/.local/share/fonts/"
mkdir -p $fontdir && cp -r home/.local/share/fonts/* $fontdir

# cinnamond desktop configuration
cp -r home/.cinnamon $USERHOME
cp -r home/.config/* $USERHOME/.config/

# themes
mkdir $USERHOME/.themes
cp -r home/.themes/* $USERHOME/.themes/

# dotfiles
cp home/.gitconfig home/.bashrc home/.inputrc home/.tmux.conf $USERHOME

# my programs
cp -r home/myPrograms $USERHOME

# kmonad service
cat << EOF > kmonad.service
[Unit]
Description=My custom kmonad service
[Service]
ExecStart=/bin/bash -c "$HOME/myPrograms/kmonad/kmonad $HOME/myPrograms/kmonad/config.kbd"
Type=oneshot
[Install]
WantedBy=multi-user.target
EOF
sudo cp kmonad.service /etc/systemd/system/kmonad.service
sudo systemctl enable kmonad.service
rm kmonad.service

# nemo actions
cd /usr/share/nemo/actions
sudo rm add-desklets.nemo_action change-background.nemo_action new-launcher.nemo_action
cd $WORKDIR
cp home/.local/share/nemo/actions/vscode.nemo_action $USERHOME/.local/share/nemo/actions/

# login window config
echo "
[Greeter]
background=/usr/share/backgrounds/tiles/blackscreen
theme-name=Mint-Y-Dark
icon-theme-name=Mint-Y-Dark
" | sudo tee /etc/lightdm/slick-greeter.conf

# firefox
FIREFOX=`find $USERHOME/.mozilla/firefox/*.default-release | head -n 1`
test -n "$FIREFOX" && cp -rf home/.mozilla/firefox/.default-release/* $FIREFOX

# rpm fusion
sudo dnf -y install dnf-plugins-core
sudo dnf install -y \
https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo 
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
# enable vscode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
# enable google chrome
sudo dnf install -y fedora-workstation-repositories
sudo dnf config-manager --set-enabled google-chrome

# install programs
onlyoffice="https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors.x86_64.rpm"
zoom="https://zoom.us/client/latest/zoom_x86_64.rpm"
sudo dnf install -y openh264 htop bat git 
sudo dnf install -y code google-chrome-stable steam telegram-desktop discord $onlyoffice 
sudo dnf install -y qbittorrent $zoom

# install flatpak & flathub
# sudo dnf install -y flatpak
# flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# flatpak install -y flathub

# load dconf
echo user-db:user > temporary-profile
DCONF_PROFILE="$(pwd)/temporary-profile" dconf load / < my-cinnamon.dconf
