{ config, pkgs, ...}:

{
    imports = [ ./base-home.nix ];

    home.username = "vivax";
    home.homeDirectory = "/home/vivax";

    home.packages = with pkgs; [
        # games
        protontricks
        protonup-ng # proton-GE

        nvtop # Nvidia usage
        gifsicle # gif optimizer
        btop
    ];

    programs.kitty = {
        enable = true;
        shellIntegration.enableFishIntegration = true;
        font.name = "Fira Code Nerdfont";
        settings = {
            font_size = 18;
            disable_ligratures = "cursor";
            background_opacity = "0.9";
            shell = "fish";
        };
        extraConfig = ( builtins.readFile ./colors/kitty.conf );
    };

    home.file.".config/hypr/hyprland.conf".source = ./dotfiles/hyprland.conf;
    home.file.".config/waybar/config".source =  ./dotfiles/waybar;
    home.file.".config/waybar/style.css".source = ./dotfiles/waybar.css;
    home.file.".config/tofi/config".source = ./dotfiles/tofi;
}
