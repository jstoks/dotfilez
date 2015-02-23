
here=$(dirname $0)

if [[ ! -f "$here/_git" ]]; then
  echo "Installing git completion"
  wget -O "$here/_git" https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
fi
