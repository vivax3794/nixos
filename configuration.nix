# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }@inputs:


{
    imports =
    [ 
        # Include the results of the hardware scan.
        ./hardware-configuration.nix
        # use community cache
        ./cachix.nix
    ];

    # Nix settings
    nix.settings.experimental-features = ["nix-command" "flakes"];
    nixpkgs.config.allowUnfree = true;

    # Clean up
    nix.optimise.automatic = true;
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    # Hyprland
    programs.hyprland.enable = true;
    programs.waybar.enable = true;
    programs.xwayland.enable = true;
    xdg.portal = {
        enable = true;

        extraPortals = [
            pkgs.xdg-desktop-portal
            pkgs.xdg-desktop-portal-gtk
        ];
    };
    security.polkit.enable = true;	
    environment.sessionVariables = {
        NIXOS_OZONE_WL = "1";
    };

    # Auto login
    services.greetd = {
        enable = true;
        settings = rec {
            initial_session = {
                command = "Hyprland";
                user = "vivax";
            };
            default_session = initial_session;
        };
    };

    users.users.vivax = {
        isNormalUser = true;
        description = "vivax";
        extraGroups = [ "networkmanager" "wheel" "video" "docker"];
        packages = with pkgs; [];
    };

    # To allow flashing keyboard
    hardware.keyboard.zsa.enable = true;

    # List packages installed in system profile.
    environment.systemPackages = with pkgs; [
        cachix

        # shell
        fish

        # Wayland
        wayland
        wl-clipboard
        wally-cli
        pyprland
        wlogout

        dunst # Notification
        swaybg

        # virtual cam
        linuxPackages.v4l2loopback
        v4l-utils

        # Portals
        xdg-desktop-portal
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
        polkit-kde-agent # Password asker thing

        # screenshooting
        grim
        slurp
        libnotify

        # sound
        pavucontrol
    ];
    fonts.packages = with pkgs; [
        fira-code
        fira-code-symbols
        nerdfonts
    ];

    programs.git = {
      enable = true;
      lfs.enable = true;
    };


    # Shell
    programs.fish.enable = true;
    users.defaultUserShell = pkgs.fish;
    environment.shells = [pkgs.fish];

    # Docker
    virtualisation.docker.enable = true;
    virtualisation.docker.enableNvidia = true;

    # Ollama
    services.ollama = {
        enable = true;
        acceleration = "cuda";
    };

    # Audio
    services.pipewire = {
        enable = true;
        audio.enable = true;
        pulse.enable = true;
        jack.enable = true;
        alsa.enable = true;

    };
    hardware.bluetooth.enable = true;


    # Virtual cam setup
    boot.kernelModules = ["v4l2loopback" "coretemp" "lm75" "nct6775"];
    boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];
    boot.extraModulePackages = [pkgs.linuxPackages.v4l2loopback];
    boot.extraModprobeConfig = ''
    options v4l2loopback exclusive_caps=1
    '';

    # Network
    networking.networkmanager.enable = true;
    networking.hostName = "nixos";
    networking.firewall = {
        enable = true;
        allowedTCPPorts = [ ];
    };

    # Local info
    time.timeZone = "Europe/Oslo";
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
        LC_ADDRESS = "nb_NO.UTF-8";
        LC_IDENTIFICATION = "nb_NO.UTF-8";
        LC_MEASUREMENT = "nb_NO.UTF-8";
        LC_MONETARY = "nb_NO.UTF-8";
        LC_NAME = "nb_NO.UTF-8";
        LC_NUMERIC = "nb_NO.UTF-8";
        LC_PAPER = "nb_NO.UTF-8";
        LC_TELEPHONE = "nb_NO.UTF-8";
        LC_TIME = "nb_NO.UTF-8";
    };

    system.stateVersion = "23.05"; # DO NOT CHANGE
}
