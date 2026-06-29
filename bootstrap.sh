#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$ROOT_DIR/lib/common.sh"
source "$ROOT_DIR/lib/packages.sh"
source "$ROOT_DIR/lib/git.sh"
source "$ROOT_DIR/lib/ssh.sh"
source "$ROOT_DIR/lib/dotfiles.sh"

main() {
  require_apt
  install_packages
  setup_git
  setup_ssh_key
  setup_signing
  link_dotfiles
  register_github
  clone_nvim_config
}

main "$@"
