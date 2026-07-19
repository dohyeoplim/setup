install_gh() {
  command -v gh >/dev/null && return
  sudo mkdir -p -m 755 /etc/apt/keyrings
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg >/dev/null
  sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
    | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null
  sudo apt-get update -qq
  sudo apt-get install -y gh
}

install_nvim() {
  command -v nvim >/dev/null && [ -d /opt/nvim ] && return
  local arch
  case "$(uname -m)" in
    x86_64) arch="x86_64" ;;
    aarch64|arm64) arch="arm64" ;;
    *) echo "unsupported arch for neovim: $(uname -m)" >&2; return 1 ;;
  esac
  local asset="nvim-linux-${arch}.tar.gz"
  curl -fsSL "https://github.com/neovim/neovim/releases/latest/download/${asset}" -o "/tmp/${asset}"
  sudo rm -rf /opt/nvim
  sudo mkdir -p /opt/nvim
  sudo tar -xzf "/tmp/${asset}" -C /opt/nvim --strip-components=1
  sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim
  rm -f "/tmp/${asset}"
}

install_uv() {
  command -v uv >/dev/null && return
  curl -LsSf https://astral.sh/uv/install.sh | sh
}

install_tailscale() {
  command -v tailscale >/dev/null || curl -fsSL https://tailscale.com/install.sh | sh
  tailscale status >/dev/null 2>&1 && return
  tailscale status 2>&1 | grep -qi "tailscaled" && return
  sudo tailscale up
}

install_claude_code() {
  command -v claude >/dev/null && return
  curl -fsSL https://claude.ai/install.sh | bash
}

install_packages() {
  sudo apt-get update -qq
  sudo apt-get install -y git git-lfs tmux curl ripgrep
  install_gh
  install_nvim
  install_uv
  install_tailscale
  install_claude_code
}
