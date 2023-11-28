{ config, pkgs, ...}:

{
    imports = [ ./base-home.nix ];

    home.username = "nixos";
    home.homeDirectory = "/home/nixos";

    home.packages = with pkgs; [
        pandoc
    ];
}
