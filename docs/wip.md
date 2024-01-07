# NixOS Minimal Installer Guide

## Installation Summary
`sudo -i`

Download configs.
```
curl -LJO https://github.com/brianaung/home-manager/archive/refs/heads/main.tar.gz
tar -zxvf home-manager-main.tar.gz
```

`nix-shell -p gnumake`

`make bootstrap`

### For new machines
`cp /etc/nixos/configuration.nix machines/<NIXNAME>.nix`
`cp /etc/nixos/hardware-configuration.nix machines/hardwares/<NIXNAME>.nix`

update `<NIXNAME>.nix`
- update path to hardware configuration
- add path to shared config
- remove `nix.settings.experimental-features = ...`

update `flake.nix`:
```
<NIXNAME> = mkSystem "<NIXNAME>" {
	system = "<ARCHITECTURE>";
	user = "<USER>";
};
```

rebuild:
```
nixos-rebuild switch --flake .#<NIXNAME>
```

```
passwd <user>
```
