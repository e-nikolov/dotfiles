# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=/home/enikolov/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#POWERLEVEL9K_MODE='awesome-fontconfig'
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history time)

ZSH_THEME="powerlevel9k/powerlevel9k"
#ZSH_THEME="sorin"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
 # ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
 COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git z git-flow-completion go command-not-found common-aliases debian docker sudo zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

DEFAULT_USER=$(whoami)

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias tf="terraform"
alias k="kubectl"
alias kx="kubectx"
alias kn="kubens"

alias zfg="subl ~/.zshrc"
alias rsrc="source ~/.zshrc"
alias xc="xclip -selection clipboard"
alias gi="go install ./..."
alias sudo='sudo -E env "PATH=$PATH"'
alias scode='sudo code --user-data-dir ~/codee'
alias dc="docker-compose"
alias dcu="docker-compose up"
alias dcr="docker-compose run"
alias dclt="docker-compose logs --follow --tail=100"
alias d="docker"
alias dci=docker_install

docker_install() {
    installer=$1

    # default to ohmyssh images
    if [[ ! $installer = *"/"* ]]; then
      installer=ohmyssh/$installer
    fi

    docker run --rm -v /opt/bin:/target $installer
    docker rmi $installer
}


sfs() {
    mkdir /tmp/$1
    sshfs $1:/ /tmp/$1
    nohup dolphin /tmp/$1 &>/dev/null &
}

sin() {
cat << EOF >> ~/.ssh/config

Host $1
    User $2
    HostName $3

EOF
}

export GOPATH=~/go/
export PATH=$PATH:/usr/local/go/bin:/opt/bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/node-v6.11.2-linux-x64/bin/
export PATH="$HOME/.cargo/bin:$PATH"
export GOROOT=/usr/local/go
export SOFTHSM2_CONF=$HOME/softhsm2.conf
export GPG_TTY=$(tty)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[[ -s "/home/enikolov/.gvm/scripts/gvm" ]] && source "/home/enikolov/.gvm/scripts/gvm"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /home/enikolov/go/bin/vault vault

if [ -e /home/enikolov/.nix-profile/etc/profile.d/nix.sh ]; then . /home/enikolov/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
if [ /usr/bin/kubectl ]; then source <(kubectl completion zsh); fi
