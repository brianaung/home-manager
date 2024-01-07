# This function creates a NixOS system based on our VM setup for a
# particular architecture.
{ nixpkgs, inputs }:

name:
{
  system,
  user,
}:

let
  machineConfig = ../machines/${name}.nix;
  userOSConfig = ../users/${user}/nixos.nix;
  userHMConfig = ../users/${user}/home.nix;

	systemFunc = nixpkgs.lib.nixosSystem;
in systemFunc rec {
  inherit system;
  modules = [
    machineConfig
    userOSConfig
		home-manager.nixosModules.home-manager {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${user} = import userHMConfig 
			home-manager.extraSpecialArgs = {
				inherit inputs user;
			};
    };
  ];
}
