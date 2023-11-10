# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:


{
    nix.settings.experimental-features = ["nix-command" "flakes"];
    nix.optimise.automatic = true;
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    imports =
    [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
    ];

    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.permittedInsecurePackages = [
        "electron-24.8.6"
    ];	


    nixpkgs.overlays = [
        (self: super: {
                waybar = super.waybar.overrideAttrs (oldAttrs: {
                    mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
            });
        })
    ];

    #false Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    security.polkit.enable = true;	

    networking.hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "Europe/Oslo";

    # Select internationalisation properties.
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

    # Configure keymap in X11
    services.xserver = {
        layout = "no";
        xkbVariant = "";
        enable = true;

        displayManager.gdm.enable = true;
    };
    programs.hyprland.enable = true;
    programs.hyprland.enableNvidiaPatches = true;
    programs.waybar.enable = true;
    programs.xwayland.enable = true;

    xdg.portal = {
        enable = true;

        wlr.enable = true;
        extraPortals = [
            pkgs.xdg-desktop-portal
            pkgs.xdg-desktop-portal-gtk
        ];
    };

    # programs.sway.enable = true;

    # Configure console keymap
    console.keyMap = "no";

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.vivax = {
        isNormalUser = true;
        description = "vivax";
        extraGroups = [ "networkmanager" "wheel" "video" "docker"];
        packages = with pkgs; [];
    };

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        wayland
        wl-clipboard

        dunst # notifications
        swww  # wallpaper

        # shell
        fish

        # virtual cam
        linuxPackages.v4l2loopback
        v4l-utils

        xdg-desktop-portal
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland

        # screenshooting
        grim
        slurp
        libnotify
        imagemagick
        ffmpeg

        # sound
        pavucontrol

        polkit-kde-agent # Password asker thing
        appimage-run
    ];

    boot.binfmt.registrations.appimage = {
        wrapInterpreterInShell = false;
        interpreter = "${pkgs.appimage-run}/bin/appimage-run";
        recognitionType = "magic";
        offset = 0;
        mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
        magicOrExtension = ''\x7fELF....AI\x02'';
    };


    programs.fish.enable = true;
    users.defaultUserShell = pkgs.fish;
    environment.shells = [pkgs.fish];

    virtualisation.docker.enable = true;


    # For obs virtual cam
    boot.kernelModules = ["v4l2loopback"];
    boot.extraModulePackages = [pkgs.linuxPackages.v4l2loopback];
    boot.extraModprobeConfig = ''
    options v4l2loopback exclusive_caps=1
    '';

    services.pipewire = {
        enable = true;
        audio.enable = true;
        pulse.enable = true;
        jack.enable = true;
        alsa.enable = true;

        };
        hardware.bluetooth.enable = true;

        environment.sessionVariables = {
        WLR_NO_HARDWARE_CURSORS="1";
        NIXOS_OZONE_WL = "1";
    };

    fonts.packages = with pkgs; [
        fira-code
        fira-code-symbols
        nerdfonts
    ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.05"; # Did you read the comment?
}
