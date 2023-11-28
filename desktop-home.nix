{ config, pkgs, ...}:

{
    imports = [ ./base-home.nix ];

    home.username = "vivax";
    home.homeDirectory = "/home/vivax";

    home.packages = with pkgs; [
        # games
        protontricks
        protonup-ng # proton-GE
        prismlauncher
        dolphin-emu

        nvtop # Nvidia usage
    ];

    programs.kitty = {
        enable = true;
        shellIntegration.enableFishIntegration = true;
        font.name = "Fira Code Nerdfont";
        settings = {
            font_size = 14;
            disable_ligratures = "cursor";
            background_opacity = "0.9";
            shell = "zellij";
        };
        extraConfig = ( builtins.readFile ./colors/kitty.conf );
    };

    home.file.".config/hypr/hyprland.conf".source = ./dotfiles/hyprland.conf;
    home.file.".config/waybar/config".source =  ./dotfiles/waybar;
    home.file.".config/waybar/style.css".source = ./dotfiles/waybar.css;
    home.file.".config/tofi/config".source = ./dotfiles/tofi;

    home.file.".config/hypr/hyprpaper.conf".text = let
        monitor1 = "/etc/nixos/wallpaper/monitor1.jpg";
        monitor2 = "/etc/nixos/wallpaper/monitor2.jpg";
    in ''
    preload = ${monitor1} 
    preload = ${monitor2} 

    wallpaper = HDMI-A-1,${monitor1}
    wallpaper = DP-1,${monitor2}
    '';
}
