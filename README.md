# dotfiles

This repo contains my configurations for the linux fedora cinnamon edition.

After running install.sh:

- Set kmonad config.kbd input device:
  `sudo find /dev/input/by-path/*event-kbd | head -n 1`
- Install nvidia driver `dnf install akmod-nvidia`
- Change dns settings:
  ```bash
  nmcli connection show
  nmcli con mod <network_profile> ipv4.dns "8.8.8.8 8.8.4.4"
  ```
