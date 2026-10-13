# A compact single-line prompt that redraws cleanly when the terminal resizes.
setopt prompt_subst
VIRTUAL_ENV_DISABLE_PROMPT=1

# Use the terminal palette so the prompt and command output stay coordinated.
ZSH_THEME_GIT_PROMPT_PREFIX=' %F{magenta}('
ZSH_THEME_GIT_PROMPT_SUFFIX='%F{magenta})%f'
ZSH_THEME_GIT_PROMPT_DIRTY=' %F{yellow}*%f'
ZSH_THEME_GIT_PROMPT_CLEAN=''

function virtualenv_prompt_info() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    print -r -- " ${VIRTUAL_ENV:t}"
  fi
}

# Separate active environments so their names never run together.
function syhomadara_environment_info() {
  local segment
  local -a segments

  if [[ -n "$VIRTUAL_ENV" ]]; then
    segments+=("$(virtualenv_prompt_info)")
  fi
  if (( $+functions[ruby_prompt_info] )); then
    segment=$(ruby_prompt_info)
    [[ -n "$segment" ]] && segments+=("$segment")
  fi
  if (( $+functions[conda_prompt_info] )); then
    segment=$(conda_prompt_info)
    [[ -n "$segment" ]] && segments+=("$segment")
  fi

  print -rn -- "${(j: · :)segments}"
}

# Escape percent signs in environment names before prompt expansion.
function syhomadara_environment_prompt() {
  local environment=$(syhomadara_environment_info)
  print -rn -- "${environment//\%/%%}"
}

PROMPT='%B%F{blue}%1~%f%b$(git_prompt_info) %(?.%F{green}.%F{red})➜%f '

# Successful commands leave the right side empty unless an environment is active.
RPROMPT='%F{yellow}$(syhomadara_environment_prompt)%f%(?.. %F{red}exit %?%f)'
PS2='%F{cyan}%_ ➜%f '
