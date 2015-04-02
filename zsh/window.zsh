# From http://dotfiles.org/~_why/.zshrc
# Sets the window title nicely no matter where you are
function title() {
  # escape '%' chars in $1, make nonprintables visible
  a=${(V)1//\%/\%\%}

  # Truncate command, and join lines.
  a=$(print -Pn "%40>...>$a" | tr -d "\n")

  case $TERM in
  screen*)
    print -Pn "\e]1;$(tmux display-message -p '#S'):q\a" # screen title (in ^A")
    ;;
  xterm*|rxvt)
    print -Pn "\e]2;$3\a" # plain xterm title ($3 for pwd)
    echo -ne "\e]1;$PWD\a"
    ;;
  esac
}
