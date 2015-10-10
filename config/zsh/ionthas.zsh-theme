
local ret_status="%{$fg_bold[red]%}>%{$fg_bold[yellow]%}>%{$fg_bold[green]%}> "

PROMPT='$(git_prompt_info) ${ret_status}%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}(%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[blue]%}) %{$fg[red]%}!"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
