# NixOS Minimal Installer Guide

## Installation Summary
### Partioning, formatting and installation
```
sudo -i
parted /dev/sda -- mklabel gpt
parted /dev/sda -- mkpart root ext4 512MB -8GB
parted /dev/sda -- mkpart swap linux-swap -8GB 100%
parted /dev/sda -- mkpart ESP fat32 1MB 512MB
parted /dev/sda -- set 3 esp on

mkfs.ext4 -L nixos /dev/sda1
mkswap -L swap /dev/sda2
swapon /dev/sda2
mkfs.fat -F 32 -n boot /dev/sda3        # (for UEFI systems only)
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot                      # (for UEFI systems only)
mount /dev/disk/by-label/boot /mnt/boot # (for UEFI systems only)
nixos-generate-config --root /mnt
nano /mnt/etc/nixos/configuration.nix
nixos-install
reboot
```

### Curl the repo
Curl the configs:
```
curl -LJO https://github.com/brianaung/home-manager/archive/refs/heads/main.tar.gz
```

Extract:
```
tar -zxvf main.tar.gz
```

Rebuild system with config.
```
sudo nixos-rebuild switch --flake .#<machine>
```

```
passwd <user>
```
