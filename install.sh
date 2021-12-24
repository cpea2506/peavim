set -eo pipefail

declare -r INSTALL_PREFIX="${INSTALL_PREFIX:-"$HOME/.local"}"

declare -r XDG_DATA_HOME="${XDG_DATA_HOME:-"$HOME/.local/share"}"
declare -r XDG_CACHE_HOME="${XDG_CACHE_HOME:-"$HOME/.cache"}"
declare -r XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"$HOME/.config"}"

declare -r RUNTIME_DIR="${RUNTIME_DIR:-"$XDG_DATA_HOME/peavim"}"
declare -r CONFIG_DIR="${CONFIG_DIR:-"$XDG_CONFIG_HOME/pvim"}"
declare -r BASE_DIR="${BASE_DIR:-"$RUNTIME_DIR/pvim"}"

function remove_old_cache_files() {
  local packer_cache="$CONFIG_DIR/plugin/packer_compiled.lua"
  if [ -e "$packer_cache" ]; then
    echo "Removing old packer cache file"
    rm -f "$packer_cache"
  fi
}

function setup_shim() {
  if [ ! -d "$INSTALL_PREFIX/bin" ]; then
    mkdir -p "$INSTALL_PREFIX/bin"
  fi

  cat >"$INSTALL_PREFIX/bin/pvim" <<EOF
#!/bin/sh
export CONFIG_DIR="\${CONFIG_DIR:-$CONFIG_DIR}"
export RUNTIME_DIR="\${RUNTIME_DIR:-$RUNTIME_DIR}"
exec nvim -u "\$RUNTIME_DIR/pvim/init.lua" "\$@"
EOF
  chmod +x "$INSTALL_PREFIX/bin/pvim"
}

function setup_pvim() {

  remove_old_cache_files

  echo "Installing Peavim shim"

  setup_shim

  echo "Preparing Packer setup"

  "$INSTALL_PREFIX/bin/pvim" --headless \
    -c 'autocmd User PackerComplete quitall' \
    -c 'PackerSync'

  echo "Packer setup complete"
}

function clone_pvim() {
  echo "Cloning PeaVim configuration"
  if ! git clone \
    --depth 1 "https://github.com/peavim.git" "$BASE_DIR"; then
    echo "Failed to clone repository. Installation failed."
    exit 1
  fi
}

function print_logo() {
  cat <<'EOF'
        _____________________   _________   ____.___   _____   
        \______   \_   _____/  /  _  \   \ /   /|   | /     \  
         |     ___/|    __)_  /  /_\  \   Y   / |   |/  \ /  \ 
         |    |    |        \/    |    \     /  |   /    Y    \
         |____|   /_______  /\____|__  /\___/   |___\____|__  /
                          \/         \/                     \/ 
EOF
}

function main() {
  print_logo
  clone_pvim
  setup_pvim

  echo "You can start it by running: $INSTALL_PREFIX/bin/pvim"
}

main "$@"
