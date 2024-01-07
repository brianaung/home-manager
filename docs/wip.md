# NixOS Minimal Installer Guide

## Installation Summary
### Setup network
wip

### Bootstraping
Lauch shell as root user > `sudo -i`.

Partition and format disks, then install.
- Curl the makefile > `curl -O https://raw.githubusercontent.com/brianaung/home-manager/main/makefile`.
- Then run > `make bootstrap`.

### For new machines without existing configs
`cp /etc/nixos/configuration.nix machines/<NIXNAME>.nix`
`cp /etc/nixos/hardware-configuration.nix machines/hardwares/<NIXNAME>.nix`

update `<NIXNAME>.nix`
- update path to hardware configuration
- add path to shared config
- remove `nix.settings.experimental-features = ...`

update `flake.nix`:
```nix
<NIXNAME> = mkSystem "<NIXNAME>" {
	system = "<ARCHITECTURE>";
	user = "<USER>"; # check `users/<USER>/nixos.nix` file to update user account details
};
```

### Rebuilding
Rebuild the system > `nixos-rebuild switch --flake .#<NIXNAME>`.

Generate hashed password > `mkpasswd`. Then Store it in `/etc/passwordFile`.
