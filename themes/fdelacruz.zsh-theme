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
  ref=$((git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null)
  SHORT_SHA=%{$CYAN%}$(git_prompt_short_sha)%{$RESET_COLOR%}
  GIT_STATUS=$(git_prompt_status)
  [[ -n $GIT_STATUS ]] && GIT_STATUS="$GIT_STATUS"
  echo "%{$GREEN%}$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}:%{$RESET_COLOR%}$SHORT_SHA$GIT_STATUS%{$GREEN%}$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

function check_git_prompt_info() {
  if git rev-parse --git-dir > /dev/null 2>&1; then
    if [[ -z $(git_prompt_info) ]]; then
        echo "%{$fg[magenta]%}detached-head%{$reset_color%}"
    else
        echo "$(my_git_prompt_info)"
    fi
  fi
}

_fishy_collapsed_wd() {
  echo $(pwd | perl -pe '
   BEGIN {
      binmode STDIN,  ":encoding(UTF-8)";
      binmode STDOUT, ":encoding(UTF-8)";
   }; s|^$ENV{HOME}|~|g; s|/([^/.])[^/]*(?=/)|/$1|g; s|/\.([^/])[^/]*(?=/)|/.$1|g
')
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
