{ config, pkgs, lib, inputs, root, user, ... }:

{
	imports = [
		inputs.nix-colors.homeManagerModules.default

		./modules/programs/zsh.nix
		./modules/programs/git.nix
		./modules/programs/i3.nix
		./modules/programs/alacritty.nix
		./modules/programs/tmux.nix
		./modules/programs/starship.nix
		./modules/programs/zathura.nix

		./modules/scripts/tmux-sessionizer.nix
	];

	# Most programs will use colors from here, except neovim, for consistency.
	# But it is quick to update neovim as well since I will be using base16 for both.
	colorScheme = inputs.nix-colors.colorSchemes.gruvbox-material-dark-hard;

	home.username = "${user}";
	home.homeDirectory = "/home/${user}";

	home.stateVersion = "23.11";

	# if using nixos, this is quite redundant i think since I alrdy set this in system config.
	nix = {
		package = pkgs.nix;
		settings.experimental-features = ["nix-command" "flakes"];
	};

	nixpkgs = {
		config = {
			allowUnfree = true;
			# temporary fix for obsidian issue: https://github.com/junegunn/fzf/issues/337
			permittedInsecurePackages = [ "electron-25.9.0" ];
		};
	};


	home.sessionVariables = {
		EDITOR = "nvim";
		BROWSER = "brave";
		TERMINAL = "alacritty";
	};

	# Install Nix packages into your environment.
	home.packages = with pkgs; [
		brave
		spotify
		dbeaver
		flameshot
		obsidian

		(nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

		neovim
		fzf
		ripgrep
		fd
		eza
		xclip
		unzip
		curl
		ranger

		# todo: i don't know if it's idiomatic to install them globally.
		# fnm
		gnumake
		gcc
		# rustup
	];

	xdg.configFile = {
		# i want to keep this out of nix store because I edit this way too often, that I hate having to keep rebuilding for changes
		"nvim".source = 
			config.lib.file.mkOutOfStoreSymlink "/home/${user}/.config/home-manager/xdg_config/nvim"; # don't use relative path, it will link to nix store

		"ranger" = {
			source = root + "/xdg_config/ranger";
			recursive = true;
		};
	};

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}
