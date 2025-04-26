# Ensure XDG_RUNTIME_DIR is set and exists
if [[ ! -d "$HOME/.local/run" ]]; then
  mkdir -p "$HOME/.local/run"
  chmod 700 "$HOME/.local/run"
fi
export XDG_RUNTIME_DIR="$HOME/.local/run"

##start tmux
export ZSH_TMUX_CONFIG=$HOME/.config/tmux/tmux.conf
export ZSH_TMUX_AUTOSTART=true
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="mr-robot"
plugins=(git asdf colorize colored-man-pages fasd tmux zsh-syntax-highlighting zsh-autosuggestions zsh-autocomplete )
source $ZSH/oh-my-zsh.sh
source ~/.zsh_aliases
source ~/.oh-my-zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
#https://github.com/zsh-users/zsh-autosuggestions
source ~/.oh-my-zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
#https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md


###### aliases

# https://cli.github.com/
alias ghd='gh dash'

# https://github.com/sharkdp/bat
alias cat=bat

# https://github.com/jesseduffield/lazygit
alias lg=lazygit

# display git log in a graph format
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"

# https://github.com/ajeetdsouza/zoxide
alias cd=z

# https://github.com/eza-community/eza
alias ls="eza --color=always --git --no-filesize --icons=always --no-time --no-user --no-permissions"

# vim=nvim
alias vim=nvim

# https://github.com/jesseduffield/lazydocker
alias ld=lazydocker

###### base exports
#
export BAT_THEME="Dracula"
export GOPATH=$HOME/go #go workspace
export GOBIN=$GOPATH/bin #go modules binaries
export GO=/usr/local/go/bin #go main executable
export LOCAL_BIN=$HOME/.local/bin #local bin
export NVIM=/opt/nvim-linux/bin
export PATH=$PATH:$GOPATH:$GOBIN:$GO:$LOCAL_BIN:$NVIM

# set neovim as defualt editor
export EDITOR="$(which nvim)"

# XDG base directories.
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"


# zsh configuration.
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# nvm and set up bash completions.
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

###### end of base exports

# zoxide https://github.com/ajeetdsouza/zoxide
eval "$(zoxide init zsh)"

## ohmyzsh settings
# all Tab widgets
zstyle ':autocomplete:*complete*:*' insert-unambiguous yes

# all history widgets
zstyle ':autocomplete:*history*:*' insert-unambiguous yes

# ^S
zstyle ':autocomplete:menu-search:*' insert-unambiguous yes
# Use a completion menu.
zstyle ':completion:*:*' matcher-list 'm:{[:lower:]-}={[:upper:]_}' '+r:|[.]=**'

COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"

### Set up fzf key bindings and fuzzy completion
## https://github.com/junegunn/fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Setting fd as the default source for fzf
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=header,grid --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
export FZF_DEFAULT_COMMAND='fd --hidden --strip-cwd-prefix --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --strip-cwd-prefix --exclude .git"
# # fzf theme
# # https://vitormv.github.io/fzf-themes/
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#d0d0d0,fg+:#d0d0d0,bg:#121212,bg+:#262626
  --color=hl:#5f87af,hl+:#5fd7ff,info:#afaf87,marker:#87ff00
  --color=prompt:#d7005f,spinner:#af5fff,pointer:#af5fff,header:#87afaf
  --color=border:#262626,label:#aeaeae,query:#d9d9d9
  --border="sharp" --border-label="󰨽 Start searching!" --border-label-pos="1"
  --preview-window="border-bold"
  --padding="0" --margin="0" --prompt="󰩉 " --marker=" "
  --pointer=" " --separator="" --scrollbar="│" --layout="reverse"
  --info="right"
  --height="70%"'

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --exclude .git . "$1"
}

_fzf_git_fzf() {
  fzf --height 50% --tmux 90%,70% \
    --layout reverse --multi --min-height 20+ --border \
    --no-separator --header-border horizontal \
    --border-label-pos 2 \
    --color 'label:blue' \
    --preview-window 'right,50%' --preview-border line \
    --bind 'ctrl-/:change-preview-window(down,50%|hidden|)' "$@"
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}

source ~/.fzf-git.sh/fzf-git.sh

# 1password https://developer.1password.com
eval $(op signin)
eval "$(op completion zsh)"; compdef _op op
# Load secrets from 1Password using op inject
# Reads the template file, replaces references with secrets, and evaluates the output
if command -v op &> /dev/null; then
  op inject --in-file ~/.zshenv | while read -r line; do
    eval "$line"
  done
else
  echo "1Password CLI not found. Skipping loading secrets from 1Password." >&2
fi

