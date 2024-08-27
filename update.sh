echo "!!!!!!!! updating channels"
nix-channel --update
echo "!!!!!!!! updating flakes"
nix flake update
echo "!!!!!!!! updating system"
sudo nixos-rebuild boot --impure --flake "."
echo "!!!!!!!! CLEANING"
bash clean.sh
