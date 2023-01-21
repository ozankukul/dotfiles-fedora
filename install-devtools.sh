#!/bin/bash

# install devtools
sudo dnf install -y @virtualization hugo
sudo dnf install -y podman nginx rabbitmq-server
sudo dnf install -y rust golang nodejs dotnet nuget
sudo npm install -g pnpm
pnpm setup # && source $HOME/.bashrc

# install miniconda
miniconda="https://repo.anaconda.com/miniconda/Miniconda3-py310_22.11.1-1-Linux-x86_64.sh"
wget -O miniconda-installer.sh $miniconda
chmod +x miniconda-installer.sh
./miniconda-installer.sh -b -p $HOME/myPrograms/miniconda3
$HOME/myPrograms/miniconda3/bin/conda init
source $HOME/.bashrc
conda config --set auto_activate_base false