#old prompt
#export PS1="\n\h \[\033[01;94m\][\w] \[\033[01;31m\]\$(__git_ps1 \"(%s) \")\[\033[0m\]\n\[\033[01;30m\][\!]\[\033[0m\] \$ "

autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

git_visual_changes() {
  local stats="$(git diff --numstat | sed '/Gemfile\.lock/d')"
  if [[ "$stats" == "" ]]; then
    return
  fi
  local changes="$(echo $stats | cut -s -f 1,2 | sed '/-/d')"
  local added="$(echo "$changes" | cut -s -f 1 | paste -sd+ - | bc)"
  local removed="$(echo "$changes" | cut -s -f 2 | paste -sd+ - | bc)"
  local graph=
  if [[ "$(echo "$changes" | wc -l)" -gt 3 ]]; then
    graph=" $(spark -x 20 $(echo "$changes" | tr "\\t" '+' | bc | tr "\\n" ','))"
  fi
  echo "[%{$fg_bold[green]%}$added%{$reset_color%}/%{$fg_bold[red]%}$removed%{$reset_color%}]$graph"
}

git_branch() {
  echo $($git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_dirty() {
  if $(! $git status -s &> /dev/null)
  then
    echo ""
  else
    if [[ $($git status --porcelain) == "" ]]
    then
      echo "%{$fg_bold[green]%}($(git_prompt_info))%{$reset_color%}"
    else
      echo "%{$fg_bold[red]%}($(git_prompt_info))%{$reset_color%} $(git_visual_changes)"
    fi
  fi
}

git_prompt_info () {
 ref=$($git symbolic-ref HEAD 2>/dev/null) || return
# echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
 echo "${ref#refs/heads/}"
}

unpushed () {
  $git cherry -v @{upstream} 2>/dev/null
}

need_push () {
  if [[ $(unpushed) == "" ]]
  then
    echo " "
  else
    echo " with %{$fg_bold[magenta]%}unpushed%{$reset_color%} "
  fi
}

ruby_version() {
  if [[ -n `type chruby | grep "function"` ]]
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
  fi

}

rb_prompt() {
  if ! [[ -z "$(ruby_version)" ]]
  then
    echo "%{$fg_bold[yellow]%}$(ruby_version)%{$reset_color%} "
  else
    echo ""
  fi
}

directory_name() {
  echo "%{$fg_bold[blue][%}$PROMPT_HOST: %~]%{$reset_color%}"
}

export PROMPT_HOST=$(hostname -f | cut -f 1 -d .)
export PROMPT=$'\n$(rb_prompt)$(directory_name) $(git_dirty)\n› '
set_prompt () {
  export RPROMPT="%{$fg_bold[cyan]%}%{$reset_color%}"
}

precmd() {
  title "zsh" "%m" "%55<...<%~"
  set_prompt
}


