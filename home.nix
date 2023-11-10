{ config, pkgs, ...}:

{
    home.username = "vivax";
    home.homeDirectory = "/home/vivax";

    home.packages = with pkgs; [
        firefox
        chromium

        discord
        obs-studio

        fortune # random quotes

        git
        gh

        # games
        steam
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

    home.stateVersion = "23.05";
}
