{ config, pkgs, ...}:

{
    imports =
    [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
    ];

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

    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking.networkmanager.enable = true;

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

    environment.systemPackages = with pkgs; [
        wayland
        wl-clipboard

        dunst # notifications
        hyprpaper

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

        # sound
        pavucontrol

        polkit-kde-agent # Password asker thing
        appimage-run
        tofi # runner

        firefox
        chromium
        discord
        obs-studio
        steam
        obsidian
        krita

        cloudflared
    ];

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

    boot.binfmt.registrations.appimage = {
        wrapInterpreterInShell = false;
        interpreter = "${pkgs.appimage-run}/bin/appimage-run";
        recognitionType = "magic";
        offset = 0;
        mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
        magicOrExtension = ''\x7fELF....AI\x02'';
    };

}
