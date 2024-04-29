{
  pkgs,
  currentUser,
  currentHost,
  ...
}:
{
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "23.11";

  # Set your time zone.
  time.timeZone = "Australia/Melbourne";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Update kernel to latest.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # To update firmware.
  # services.fwupd.enable = true;

  # Use zram (instead of physical swap).
  zramSwap.enable = true;

  # Enable networking.
  networking.hostName = currentHost; # Define your hostname.
  networking.networkmanager.enable = true; # Enable networking

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable bluetooth support.
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Setup gui, mouse, keyboard, etc.
  # Using wayland on thorin (testing), x11 on gimli (stable)
  services.xserver.enable = true;
  services.xserver.desktopManager = {
    xterm.enable = false;
  };

  # Enable flakes.
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${currentUser} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    packages = with pkgs; [
      thunderbird
      firefox
      zathura
    ];
  };
  programs.zsh.enable = true;

  # Set session variables.
  environment.sessionVariables = rec {
    TERMINAL = "alacritty";
    NIXOS_OZONE_WL = "1";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    ripgrep
    fd
    fzf
    xfce.thunar
    btop
    neovim
    tmux
  ];

  # Install fonts.
  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
        "Terminus"
      ];
    })
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # To load/unload configured shells based on current directory.
  programs.direnv.enable = true;

  # Enable docker.
  virtualisation.docker.enable = true;

  # Enable virtualbox.
  virtualisation.virtualbox.host.enable = true;
}