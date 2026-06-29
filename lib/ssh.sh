setup_ssh_key() {
  mkdir -p "$HOME/.ssh" && chmod 700 "$HOME/.ssh"
  if [ ! -f "$SSH_KEY" ]; then
    ssh-keygen -t ed25519 -C "$GIT_EMAIL ($(hostname))" -f "$SSH_KEY" -N ""
  fi
  ssh-keygen -F github.com >/dev/null 2>&1 || ssh-keyscan github.com >>"$HOME/.ssh/known_hosts" 2>/dev/null
}

setup_signing() {
  local signers="$HOME/.config/git/allowed_signers"
  mkdir -p "$(dirname "$signers")"
  git config --global gpg.format ssh
  git config --global user.signingkey "$SSH_KEY.pub"
  git config --global commit.gpgsign true
  git config --global tag.gpgsign true
  git config --global gpg.ssh.allowedSignersFile "$signers"
  local pubkey; pubkey="$(awk '{print $1, $2}' "$SSH_KEY.pub")"
  grep -qF "$pubkey" "$signers" 2>/dev/null || echo "$GIT_EMAIL $pubkey" >>"$signers"
}

register_github() {
  gh auth status >/dev/null 2>&1 || gh auth login
  local title; title="$(hostname)-$(date +%Y%m%d)"
  gh ssh-key add "$SSH_KEY.pub" --title "$title" --type authentication 2>/dev/null || true
  gh ssh-key add "$SSH_KEY.pub" --title "$title-signing" --type signing 2>/dev/null || true
}
