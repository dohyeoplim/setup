link_dotfiles() {
  ln -sf "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
}

clone_nvim_config() {
  local dest="$HOME/.config/nvim"
  if [ -d "$dest/.git" ]; then
    git -C "$dest" pull --ff-only || true
  elif [ -e "$dest" ]; then
    echo "$dest exists and is not a git repo; skipping" >&2
  else
    mkdir -p "$HOME/.config"
    git clone "$NVIM_REPO" "$dest"
  fi
}
