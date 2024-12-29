echo "CLEANING: NIX STORE"
nix-collect-garbage --delete-older-than 1d
echo "OPTIMIZING: NIX STORE"
nix-store --optimize
echo "CLEANING: EARTHLY"
earthly prune -a
echo "CLEANING: DOCKER"
docker system prune -a -f
echo "CLEANING: Rust target folders"
rm -rfv /home/vivax/coding/**/target
