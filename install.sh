set -eo pipefail

declare -r XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"$HOME/.config"}"
declare -r CONFIG_DIR="${CONFIG_DIR:-"$XDG_CONFIG_HOME/nvim"}"
declare -r INSTALL_PREFIX="${INSTALL_PREFIX:-"$HOME/.local"}"

function msg() {
  local text="$1"
  local div_width="80"
  printf "%${div_width}s\n" ' ' | tr ' ' -
  printf "%s\n" "$text"
}

function remove_old_cache_files() {
  local packer_cache="$CONFIG_DIR/plugin/packer_compiled.lua"
  if [ -e "$packer_cache" ]; then
    echo "Removing old packer cache file"
    rm -f "$packer_cache"
  fi
}

function setup_nvim() {
  remove_old_cache_files

  echo "Preparing Packer setup"

  "nvim" --headless \
    -c 'autocmd User PackerComplete quitall' \
    -c 'PackerSync'

  echo "Packer setup complete"
}

function clone_nvim() {
  # check if nvim has existed
  [ -d "$CONFIG_DIR" ] && rm -rf $CONFIG_DIR

  msg "Cloning PeaVim configuration"
  if ! git clone \
    --depth 1 "git@github.com:cpea2506/peavim.git" "$CONFIG_DIR"; then
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
  clone_nvim
  setup_nvim

  echo "Enjoy with nvim"
}

main 
