{
	description = "My dotfiles flake.";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nix-colors.url = "github:misterio77/nix-colors";
	};

	outputs = inputs@{ nixpkgs, home-manager, ... }: {
			nixosConfigurations = {
				lenovo-5-amd = nixpkgs.lib.nixosSystem {
					system = "x86_64-linux";
					modules = [
						./machines/lenovo-5-amd.nix

						home-manager.nixosModules.home-manager
						{
							home-manager.useGlobalPkgs = true;
							home-manager.useUserPackages = true;
							home-manager.users.brianaung = import ./users/brianaung/home.nix;
							home-manager.extraSpecialArgs = {
								inherit inputs;
								root = ./.;
								user = "brianaung";
							};
						}
					];
				};
			};
		};
}
