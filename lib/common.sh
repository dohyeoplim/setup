GIT_NAME="${GIT_NAME:-}"
GIT_EMAIL="${GIT_EMAIL:-dhlim0817@gmail.com}"
SSH_KEY="$HOME/.ssh/id_ed25519"
NVIM_REPO="${NVIM_REPO:-git@github.com:dohyeoplim/vimrc.git}"
DOTFILES_DIR="$ROOT_DIR/dotfiles"

require_apt() {
  command -v apt-get >/dev/null || { echo "this script targets apt-based systems" >&2; exit 1; }
}
