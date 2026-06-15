## Installl the flake 'lily' onto the remote device.

# Get some info about the environment
TEMP=$(mktemp -d) # Create tmpdir
USER=$(whoami) # Get username

# Set up SSH key to be copied after install
install -d -m755 "${TEMP}/home/${USER}/.ssh"
cp "/home/${USER}/.ssh/id_ed25519" "${TEMP}/home/${USER}/.ssh/id_ed25519"
chmod 600 "${TEMP}/home/${USER}/.ssh/id_ed25519"

# Perform the install
# TODO: take flake name and host as args $1 and $2
export NIXPKGS_ALLOW_INSECURE=1 NIXPKGS_ALLOW_UNFREE=1 NIXPKGS_ALLOW_BROKEN=1
NIX_CONFIG="access-tokens = github.com=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" \
  nix --experimental-features 'nix-command flakes' \
  run github:nix-community/nixos-anywhere -- \
  --extra-files "${TEMP}" \
  --flake .#lily \
  --target-host root@192.168.10.141

# Clean up tmpdir
rm -rf "${TEMP}"

# Remove known_hosts entry, it will have changed if we try to connect after install
sed -ie '/^192\.168\.10\.141/d' "/home/${USER}/.ssh/known_hosts"

echo "Success!"
