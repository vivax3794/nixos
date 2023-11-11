{ config, pkgs, ...}:

{
    home.username = "vivax";
    home.homeDirectory = "/home/vivax";

    home.packages = with pkgs; [
        fortune # random quotes

        git
        gh

        # games
        protontricks
        protonup-ng # proton-GE
        prismlauncher
        dolphin-emu

        krita # Drawing
        nvtop # Nvidia usage
        obsidian

        # Neovim
        ripgrep
        fd
        tree-sitter
        clang

        neofetch
    ];

    # shell
    programs.fish = {
        enable = true;
        interactiveShellInit = ''
            function fish_greeting
                fortune
            end
        '' + (builtins.readFile ./colors/fish.fish);
        shellAliases = {
            rm = "rm -v";
            mv = "mv -v";
            cp = "cp -v";

            d = "nix develop --command fish";
            n = "nix develop --command nvim";

            dr = "nix develop '/home/vivax/flakes#rust' --command fish";
            dn = "nix develop '/home/vivax/flakes#node' --command fish";
        };
    };
    programs.starship = {
        enable = true;
        enableFishIntegration = true;
    };
    programs.kitty = {
        enable = true;
        shellIntegration.enableFishIntegration = true;
        font.name = "Fira Code Nerdfont";
        settings = {
            font_size = 12;
            disable_ligratures = "cursor";
            background_opacity = "0.9";
            shell = "zellij";
        };
        extraConfig = ( builtins.readFile ./colors/kitty.conf );
    };
    programs.zellij = {
        enable = true;
        enableFishIntegration = true;
    };

    home.file.".config/zellij/config.kdl".source = ./dotfiles/zellij.kdl;
    home.file.".config/hypr/hyprland.conf".source = ./dotfiles/hyprland.conf;
    home.file.".config/waybar/config".source =  ./dotfiles/waybar;
    home.file.".config/waybar/style.css".source = ./dotfiles/waybar.css;
    home.file.".config/tofi/config".source = ./dotfiles/tofi;

    programs.neovim = {
        enable = true;
        defaultEditor = true;
    }; 
    home.file.".config/nvim" = {
        source = ./dotfiles/nvim;
        recursive = true;
    };

    home.file.".config/hypr/hyprpaper.conf".text = let
        monitor1 = "/etc/nixos/wallpaper/monitor1.jpg";
        monitor2 = "/etc/nixos/wallpaper/monitor2.jpg";
    in ''
    preload = ${monitor1} 
    preload = ${monitor2} 

    wallpaper = HDMI-A-1,${monitor1}
    wallpaper = DP-1,${monitor2}
    '';

    home.stateVersion = "23.05";
}
