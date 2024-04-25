nix-channel --update
nix flake update
sudo nixos-rebuild switch --impure --flake ".#desktop"
nix-store --gc
nix-store --optimize
