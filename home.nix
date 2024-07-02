{ config, pkgs, inputs, lib, ...}:

{
    home.username = "vivax";
    home.homeDirectory = "/home/vivax";

    home.packages = with pkgs; [
        # Neofetch
        neofetch
        tree-sitter

        copier # Template engine

        # Git
        gh
        lazygit

        # Image stuff
        imagemagick
        ffmpeg
        gifsicle # gif optimizer

        # Node
        nodejs
        vue-language-server
        vue-language-server
        nodePackages.vls
        nodePackages.typescript-language-server

        # games
        protontricks
        protonup-ng # proton-GE
        wine

        # Usage data
        nvtopPackages.full
        btop

        # Applications
        floorp
        chromium
        obs-studio
        steam
        libresprite
        krita
        ldtk

        (pkgs.discord.override {
          withOpenASAR = true;
          withVencord = true;
        })

        # Other
        ripgrep
        fd
        clang
    ];

    # Program configs
    programs.fish = {
        enable = true;
        interactiveShellInit = builtins.readFile ./colors/fish.fish;
        shellAliases = {
            rm = "rm -v";
            mv = "mv -v";
            cp = "cp -v";

            d = "nix develop --command fish";
            n = "nix develop --command nvim";
        };
    };
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
    programs.starship = {
        enable = true;
        enableFishIntegration = true;
    };
    programs.zellij = {
        enable = true;
        # this starts zellij when you start fish
        # enableFishIntegration = true;
    };
    programs.neovim = {
        enable = true;
        defaultEditor = true;
    }; 
    home.file.".config/nvim" = {
        source = ./dotfiles/nvim;
        recursive = true;
    };
    programs.tofi = {
        enable = true;
        settings = {
            font = "Fira Code";
            font-size = 24;
            prompt-color = "#FF00FF";
            num-results = 5;
            result-spacing = 25;
            width = "100%";
            height = "100%";
            background-color = "#000C";
            outline-width = 0;
            border-width = 0;
            padding-top = "15%";
            padding-bottom = 8;
            padding-left = "35%";
            padding-right = 8;
        };
    };
    home.activation = {
        # https://github.com/philj56/tofi/issues/115#issuecomment-1701748297
        regenerateTofiCache = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
            tofi_cache=${config.xdg.cacheHome}/tofi-drun
            [[ -f "$tofi_cache" ]] && rm "$tofi_cache"
        '';
    };

    home.file.".config/zellij/config.kdl".source = ./dotfiles/zellij.kdl;
    home.file.".config/hypr/hyprland.conf".source = ./dotfiles/hyprland.conf;
    home.file.".config/hypr/pyprland.toml".source = ./dotfiles/pyprland.toml;
    home.file.".config/wlogout/layout".source = ./dotfiles/wlogout.layout.json;
    home.file.".config/waybar/config".source =  ./dotfiles/waybar;
    home.file.".config/waybar/style.css".source = ./dotfiles/waybar.css;
    home.file.".config/dunst/dunstrc".source = ./dotfiles/dunstrc.ini;

    home.stateVersion = "23.05";
}
