autoload colors && colors

if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

prompt_git_visual_changes() {
  local stats="$(git diff --numstat | sed '/^0\s\+0\|^-\|Gemfile\.lock\|schema\.rb/d')"
  if [[ "$stats" == "" ]]; then
    return
  fi
  local changes="$(echo $stats | cut -s -f 1,2 | sed '/-/d')"
  local added="$(echo "$changes" | cut -s -f 1 | paste -sd+ - | bc)"
  local removed="$(echo "$changes" | cut -s -f 2 | paste -sd+ - | bc)"
  local untracked="$(git ls-files -o --exclude-standard | wc -l)"
  local graph=
  if [[ "$(echo "$changes" | wc -l)" -gt 3 ]]; then
    graph=" |$(spark -x 20 $(echo "$changes" | tr "\\t" '+' | bc | tr "\\n" ','))|"
  fi
  echo "[%{$fg_bold[green]%}$added%{$reset_color%}/%{$fg_bold[red]%}$removed%{$reset_color%}/%{$fg_bold[yellow]%}$untracked%{$reset_color%}]$graph"
}

prompt_git_info() {
  if $(! $git status -s &> /dev/null)
  then
    echo ""
  else
    if [[ $($git status --porcelain) == "" ]]
    then
      echo "%{$fg_bold[green]%}($(prompt_git_branch))%{$reset_color%}"
    else
      echo "%{$fg_bold[red]%}($(prompt_git_branch))%{$reset_color%} $(prompt_git_visual_changes)"
    fi
  fi
}

prompt_git_branch() {
 local ref=$($git symbolic-ref HEAD 2>/dev/null) || return
 echo "${ref#refs/heads/}"
}

ruby_version() {
  if (( $+commands[chruby] ))
  then
    local v="`chruby | grep '\*'`"
    local regex='\* ([^-]*)-([^-]*)(-([^-]*))?'
    local rv=''
    if [[ $v =~ $regex ]]
    then
      rv=$match[2]
      if [[ "$match[1]" != 'ruby' ]]; then
        rv="$match[1]-$rv"
      fi
    fi
    echo $rv
  elif (( $+commands[rvm-prompt] )); then
    echo "$(rvm-prompt | awk '{print $1}')"
  else
    echo "$([[ $(ruby --version) =~ ([0-9]{1,2}\.[0-9]{1,2}\.[0-9]{1,2}) ]] && echo $match[1])"
  fi

}

prompt_ruby_version() {
  local ver="$(ruby_version)"
  if ! [[ -z "$ver" ]]
  then
    echo "%{$fg_bold[magenta]%}$ver%{$reset_color%} "
  else
    echo ""
  fi
}

prompt_directory_name() {
  echo "%{$fg_bold[blue][%}$PROMPT_HOST: %~]%{$reset_color%}"
}

prompt_host() {
  local host=$(hostname -f | cut -f 1 -d .)
  
  case "$host" in
    previewchanges)
      echo "demo"
      ;;
    *)
      echo $host
      ;;
  esac
}

export PROMPT_HOST=$(prompt_host)
export PROMPT=$'\n$(prompt_ruby_version)$(prompt_directory_name) $(prompt_git_info)\n› '

