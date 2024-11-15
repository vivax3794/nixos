# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:


{
    imports =
    [ 
        # Include the results of the hardware scan.
        ./hardware-configuration.nix
        # use community cache
        ./cachix.nix
    ];

    # nix.settings = {
    #     substituters = ["https://hyprland.cachix.org"];
    #     trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    # };

    nixpkgs.config.permittedInsecurePackages = [
        "electron-29.4.6"
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
    programs.hyprland = {
        enable = true;
        # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        # portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
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

    programs.adb.enable = true;
    users.users.vivax = {
        isNormalUser = true;
        description = "vivax";
        extraGroups = [ "networkmanager" "wheel" "video" "docker" "adbusers"];
        packages = with pkgs; [];
    };

    # To allow flashing keyboard
    hardware.keyboard.zsa.enable = true;

    # List packages installed in system profile.
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };
    environment.systemPackages = with pkgs; [
        steamcmd
        alvr

        cachix

        # cursor
        inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default

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
        polkit-kde-agent # Password asker thing

        # screenshooting
        grim

        # sound
        pavucontrol

        cloudflared

        # Cuda
        cudaPackages.cudatoolkit
        cudaPackages.cudnn

        appimage-run
        xdg-dbus-proxy

        rkvm
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
    hardware.nvidia-container-toolkit.enable = true;
    virtualisation.docker = {
        enable = true;

        autoPrune = {   
            enable = true;
            flags = ["--all"];
        };
    };

    # Ollama
    services.ollama = {
        enable = true;
        acceleration = "cuda";
        # package = pkgs.ollama.overrideAttrs (finalAttrs: previousAttrs: {
        #   version = "0.3.8";
        # });
    };

    # Audio
    # services.pipewire.wireplumber.enable = true;
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
        enable = false;
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

  #     services.wivrn = {
  #   enable = true;
  #   openFirewall = true;
  #
  #   # Write information to /etc/xdg/openxr/1/active_runtime.json, VR applications
  #   # will automatically read this and work with wivrn
  #   defaultRuntime = true;
  #
  #   # Executing it through the systemd service executes WiVRn w/ CAP_SYS_NICE
  #   # Resulting in no stutters!
  #   autoStart = true;
  # };

    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
        libGL
        xorg.libX11
        xorg.libXcursor
        xorg.libXi
        xorg.libXinerama
        xorg.libXrandr
        xorg.libXrender
        xorg.libXext
        xorg.libxcb
        libdrm
        wayland
        portaudio
        sfml
        alsa-lib
        libglvnd
        icu
        # pulseaudioLight
    ];

    system.stateVersion = "23.05"; # DO NOT CHANGE
}
