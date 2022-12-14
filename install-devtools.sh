#!/bin/bash

# install devtools
sudo dnf install -y @virtualization hugo
sudo dnf install -y podman nginx rabbitmq-server
sudo dnf install -y rust golang nodejs dotnet nuget
npm install -g pnpm && pnpm setup