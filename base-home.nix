{ config, pkgs, inputs, ...}:

{
    home.packages = with pkgs; [
        fortune # random quotes

        ripgrep
        fd
        tree-sitter
        clang

        neofetch

        cargo-generate
        lazygit
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

            dr = "nix develop '/etc/nixos/generic_shell/#rust' --command fish";
            dn = "nix develop '/etc/nixos/generic_shell/#node' --command fish";
            dp = "nix develop '/etc/nixos/generic_shell/#python' --command ipython";

            gr = "cargo-generate gen --path /etc/nixos/templates/rust";
            gb = "cargo-generate gen --path /etc/nixos/templates/bevy";
        };
    };
    programs.starship = {
        enable = true;
        enableFishIntegration = true;
    };
    programs.zellij = {
        enable = true;
        enableFishIntegration = true;
    };

    home.file.".config/zellij/config.kdl".source = ./dotfiles/zellij.kdl;

    
    programs.neovim = {
        enable = true;
        package = pkgs.neovim-nightly;
        defaultEditor = true;
    }; 
    home.file.".config/nvim" = {
        source = ./dotfiles/nvim;
        recursive = true;
    };

    home.stateVersion = "23.05";
}
