echo "CLEANING: NIX STORE"
nix-collect-garbage --delete-older-than 7d
echo "OPTIMIZING: NIX STORE"
nix-store --optimize
echo "CLEANING: DOCKER"
docker system prune -a -f
