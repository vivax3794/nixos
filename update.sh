echo "!!!!!!!! updating channels"
nix-channel --update
echo "!!!!!!!! updating flakes"
nix flake update
echo "!!!!!!!! updating system"
sudo nixos-rebuild boot --impure --flake "." --upgrade
# echo "!!!!!!!! CLEANING"
# bash clean.sh
