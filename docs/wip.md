# NixOS Minimal Installer Guide

## Installation Summary
### Setup network
wip

### Bootstraping
Lauch shell as root user > `sudo -i`.

Partition and format disks, then install the OS.
- Get the makefile > `curl -O https://raw.githubusercontent.com/brianaung/home-manager/main/makefile`.
- Then run > `make bootstrap`.

### For new machines without existing configs
Copy the generated system config files.
```
cp /etc/nixos/configuration.nix machines/<NIXNAME>.nix && \
cp /etc/nixos/hardware-configuration.nix machines/hardwares/<NIXNAME>.nix
```

Update `./machines/<NIXNAME>.nix`.
- update path to point to correct hardware configuration.
- add path to shared config.
- remove duplicate commands (those that already exists in shared config)
    ```
    nix.settings.experimental-features = [ "nix-command" "flakes" ];\n \
    nixpkgs.config.allowUnfree = true;\n \
    nixpkgs.config.permittedInsecurePackages = [ "electron-25.9.0" ];\n \
    ```

Update `flake.nix`.
```nix
<NIXNAME> = mkSystem "<NIXNAME>" {
    system = "<ARCHITECTURE>";
    user = "<USER>"; # check `users/<USER>/nixos.nix` file to update user account details
};
```

### Rebuilding
Rebuild the system > `nixos-rebuild switch --flake .#<NIXNAME>`.

Generate hashed password > `mkpasswd`. Then Store it in `/etc/passwordFile`.
