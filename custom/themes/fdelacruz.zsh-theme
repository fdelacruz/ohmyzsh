# ZSH Theme - Preview: http://cl.ly/image/0w0s301H0T1M
# Thanks lukerandall upon whose theme this is based

# Color shortcuts
RED=$fg[red]
YELLOW=$fg[yellow]
GREEN=$fg[green]
WHITE=$fg[white]
BLUE=$fg[blue]
CYAN=$fg[cyan]

RED_BOLD=$fg_bold[red]
YELLOW_BOLD=$fg_bold[yellow]
GREEN_BOLD=$fg_bold[green]
WHITE_BOLD=$fg_bold[white]
BLUE_BOLD=$fg_bold[blue]
CYAN_BOLD=$fg_bold[cyan]

RESET_COLOR=$reset_color

# The return code of the last-run application in red
local return_code="%(?..%{$RED%}%? ↵%{$RESET_COLOR%})"

function my_git_prompt_info() {
  local ref sha status_str
  ref=$( (git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2>/dev/null )
  sha="%{$CYAN%}$(git_prompt_short_sha)%{$RESET_COLOR%}"
  status_str=$(git_prompt_status)
  echo "%{$GREEN%}$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}:%{$RESET_COLOR%}$sha$status_str%{$GREEN%}$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

function check_git_prompt_info() {
  git rev-parse --is-inside-work-tree &>/dev/null || return
  if git symbolic-ref -q HEAD &>/dev/null; then
    my_git_prompt_info
  else
    echo "%{$fg[magenta]%}detached-head%{$reset_color%}"
  fi
}

_fishy_collapsed_wd() {
  local -a parts=("${(@s:/:)${(%):-%~}}")
  local out part i n
  for ((i = 1; i < $#parts; i++)); do
    part=$parts[i]
    [[ $part == (|'~') ]] && { out+="$part/"; continue; }
    [[ $part == .* ]] && n=2 || n=1
    out+="${part[1,n]}/"
  done
  print -rn -- "$out${parts[-1]}"
}

PROMPT='[%n@%m $(_fishy_collapsed_wd)$(check_git_prompt_info)%{$RESET_COLOR%}]%# '
# RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"

ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$YELLOW%}%%"
ZSH_THEME_GIT_PROMPT_ADDED="%{$YELLOW%}+"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$YELLOW%}*"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$YELLOW%}~"
ZSH_THEME_GIT_PROMPT_DELETED="%{$YELLOW%}!"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$YELLOW%}?"
