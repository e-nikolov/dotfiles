# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
export GPG_TTY=$(tty)
zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent lazy yes
zstyle :omz:plugins:ssh-agent lifetime 10m

# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
### End of Zinit's installer chunk

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
      zdharma-continuum/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
      zsh-users/zsh-completions

zinit snippet OMZ::plugins/ssh-agent/ssh-agent.plugin.zsh
zinit pack for fzf
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::command-not-found
zinit snippet OMZP::sudo
zinit load rupa/z
zinit load changyuheng/fz
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit load asdf-vm/asdf
zinit light Aloxaf/fzf-tab

[ -f ~/.kubectl_aliases ] && source ~/.kubectl_aliases

# kubectl completions
if [ /usr/bin/kubectl ]; then source <(kubectl completion zsh); fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

bindkey '^[[1;5C' emacs-forward-word
bindkey '^[[1;5D' emacs-backward-word
bindkey '^[[3;5~' kill-word

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=12'
alias zfg="code ~/.zshrc"
alias dc=docker-compose
alias dclt="docker-compose logs --tail 300 --follow"
alias d=docker
alias src="source ~/.zshrc"
alias xc="xclip -sel clip"


echo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER == echo\ * ]]; then
        LBUFFER="${LBUFFER#echo }"
    else
        LBUFFER="echo `printf %q $LBUFFER`"
    fi
}

zle -N echo-command-line
# Defined shortcut keys: [Esc] [Esc]
bindkey "\e\`" echo-command-line

typeset -g POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm|kubens|kubectx|oc|istioctl|kogito|k9s|helmfile|make'

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(kubecontext os_icon dir vcs newline prompt_char)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status asdf root_indicator command_execution_time background_jobs history direnv virtualenv anaconda pyenv goenv nodeenv fvm luaenv jenv plenv phpenv scalaenv haskell_stack kubecontext terraform aws aws_eb_env azure gcloud google_app_cred context nordvpn ranger nnn vim_shell midnight_commander nix_shell todo timewarrior taskwarrior time newline)
typeset -g POWERLEVEL9K_ASDF_PROMPT_ALWAYS_SHOW=true
typeset -g POWERLEVEL9K_ASDF_NODEJS_SHOW_ON_UPGLOB='*.js|package.json'
typeset -g POWERLEVEL9K_ASDF_ERLANG_SHOW_ON_UPGLOB='mix.lock|*.ex'
typeset -g POWERLEVEL9K_ASDF_ELIXIR_SHOW_ON_UPGLOB='mix.lock|*.ex'
typeset -g POWERLEVEL9K_ASDF_GOLANG_SHOW_ON_UPGLOB='go.mod'
typeset -g POWERLEVEL9K_ASDF_RUST_SHOW_ON_UPGLOB='Cargo.lock|Cargo.toml|*.rs'
typeset -g POWERLEVEL9K_ASDF_SOLIDITY_SHOW_ON_UPGLOB='truffle-config.js|*.sol'
typeset -g POWERLEVEL9K_ASDF_SQLITE_SHOW_ON_UPGLOB='*.sqlite'

