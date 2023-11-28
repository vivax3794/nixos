{ config, pkgs, ...}:

{
    imports = [ ./base-home.nix ];

    home.username = "nixos";
    home.homeDirectory = "/home/nixos";
}
