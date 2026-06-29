setup_git() {
  [ -n "$GIT_NAME" ] || read -rp "git user.name: " GIT_NAME
  [ -n "$GIT_EMAIL" ] || read -rp "git user.email: " GIT_EMAIL
  git config --global user.name "$GIT_NAME"
  git config --global user.email "$GIT_EMAIL"
  git config --global init.defaultBranch main
  git config --global pull.rebase true
  git config --global push.default current
  git config --global push.autoSetupRemote true
  git config --global fetch.prune true
  git config --global rebase.autoStash true
  git config --global merge.conflictStyle zdiff3
  git config --global rerere.enabled true

  git config --global alias.st status
  git config --global alias.co checkout
  git config --global alias.br branch
  git config --global alias.unstage "reset HEAD --"
  git config --global alias.amend "commit --amend --no-edit"
  git config --global alias.tree "log --graph --decorate --pretty=oneline --abbrev-commit"
  git config --global alias.d diff
  git config --global alias.ds "diff --staged"
  git config --global alias.cm "commit -m"
  git config --global alias.ps push
  git config --global alias.a "add ."

  git lfs install --skip-repo
}
