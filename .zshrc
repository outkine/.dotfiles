# ======== zplugin
# if [[ ! -f ~/.zplugin/zplugin.zsh ]]; then
#   git clone https://github.com/akatrevorjay/zplugin "${HOME}/.zplugin"
# fi

# source "${HOME}/.zplugin/zplugin.zsh"

# zplugin load 'zsh-users/zsh-syntax-highlighting'
# zplugin load 'zsh-users/zsh-history-substring-search'
# zplugin load 'zsh-users/zsh-autosuggestions'
# zplugin load 'zsh-users/zsh-completions'
# zplugin load 'geometry-zsh/geometry'

# ======== zgen
if [[ ! -f ~/.zgen/zgen.zsh ]]; then
  git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
fi

source "${HOME}/.zgen/zgen.zsh"

# if the init scipt doesn't exist
if ! zgen saved; then
  zgen load 'zsh-users/zsh-syntax-highlighting'
  zgen load 'zsh-users/zsh-history-substring-search'
  zgen load 'zsh-users/zsh-autosuggestions'
  zgen load 'zsh-users/zsh-completions'
  # zgen load 'lukechilds/zsh-better-npm-completion'
  zgen load 'geometry-zsh/geometry'

  zgen save
fi

# ======== Options
# ===== Basics
setopt no_beep              # don't beep on error
setopt interactive_comments # Allow comments even in interactive shells (especially for Muness)

# ===== Changing Directories
setopt auto_cd           # If you type foo, and it isn't a command, and it is a directory in your cdpath, go there
setopt cdablevarS        # if argument to cd is the name of a parameter whose value is a valid directory, it will become the current directory
setopt pushd_ignore_dups # don't push multiple copies of the same directory onto the directory stack
setopt auto_pushd        # make cd push the old directory onto the directory stack
setopt pushdminus        # swapped the meaning of cd +1 and cd -1; we want them to mean the opposite of what they mean im csh

# ===== Expansion and Globbing
setopt extendedglob # treat #, ~, and ^ as part of patterns for filename generation

# ===== History
setopt append_history         # Allow multiple terminal sessions to all append to one zsh command history
setopt extended_history       # save timestamp of command and duration
setopt inc_append_history     # Add comamnds as they are typed, don't wait until shell exit
setopt hist_expire_dups_first # when trimming history, lose oldest duplicates first
setopt hist_ignore_dups       # do not write events to history that are duplicates of previous events
setopt hist_ignore_all_dups   # delete old recorded entry if new entry is a duplicate.
setopt hist_ignore_space      # remove command line from history list when first character on the line is a space
setopt hist_find_no_dups      # when searching history don't display results already cycled through twice
setopt hist_reduce_blanks     # remove extra blanks from each command line being added to history
setopt hist_verify            # don't execute, just expand history
setopt share_history          # imports new commands and appends typed commands to history
#setopt hist_no_store          # remove the history (fc -l) command from the history list when invoked
setopt long_list_jobs         # list jobs in the long format by default

# ===== Completion
setopt always_to_end      # when completing from the middle of a word, move the cursor to the end of the word
setopt auto_menu          # show completion menu on successive tab press. needs unsetop menu_complete to work
setopt auto_name_dirs     # any parameter that is set to the absolute name of a directory immediately becomes a name for that directory
setopt complete_in_word   # allow completion from within a word/phrase
setopt auto_list          # automatically list choices on ambiguous completion.
unsetopt complete_aliases   # an alias of a command should complete to the command completion
unsetopt menu_complete    # do not autoselect the first completion entry
unsetopt flowcontrol      # do not freezes output to the terminal until you type ^q

# ===== Correction
# setopt correct # spelling correction for commands
# setopt correct_all # spelling correction for arguments

# ===== Prompt
setopt prompt_subst      # enable parameter expansion, command substitution, and arithmetic expansion in the prompt
setopt transient_rprompt # only show the rprompt on the current prompt
unsetopt auto_name_dirs  # do not set auto_name_dirs because it messes up prompts

# ===== Scripts and Functions
setopt multios # perform implicit tees or cats when multiple redirections are attempted

# ZSH Completion config
zstyle '*' single-ignored show
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# Process completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion::complete:*' use-cache 1
# zstyle ':completion::complete:*' cache-path "$HOME/.zsh/cache"

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
        clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
        gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
        ldap lp mail mailman mailnull man messagebus  mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
        operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
        usbmux uucp vcsa wwwrun xfs '_*'

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate
zstyle ':completion:*' menu select=1 _complete _ignored _approximate

# asdf (elixir version manager)
. $HOME/.asdf/asdf.sh
# . $HOME/.asdf/completions/asdf.bash

# ======== Exports
SAVEHIST=10000000000000000
HISTSIZE=10000000000000000
HISTFILE=~/.zsh_history
DISABLE_CORRECTION="true"
export PATH=~/.asdf/installs/nodejs/9.0.0/.npm/bin:~/.bin:~/.gem/ruby/2.5.0/bin:~/.local/bin:~/.poetry/bin:~/.opam/system/bin:~/.config/yarn/global/node_modules/.bin:$PATH

export VISUAL=nvim
export EDITOR="$VISUAL"
export ELECTRON_TRASH=gio
export NODE_PATH=~/.asdf/installs/nodejs/9.0.0/.npm/bin

#https://github.com/jwilm/alacritty/issues/1021
export W3MIMGDISPLAY_PATH=~/.bin/w3m_fix
export ERL_AFLAGS="-kernel shell_history enabled"


# ======= Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
export LESS_TERMCAP_so=$(printf '\33[5;30;43m')
export LESS_TERMCAP_se=$(printf '\33[m')

# ======== Vim
bindkey -v

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
#bindkey 'j' history-substring-search-up
#bindkey 'k' history-substring-search-down

export KEYTIMEOUT=1


# ======== FASD
fasd_cache="$HOME/.fasd-init-zsh"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  fasd --init auto >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache


# ======== VirtualEnv
_virtualenv_auto_activate() {
    if [ -e "venv" ]; then
        # Check to see if already activated to avoid redundant activating
        if [ "$VIRTUAL_ENV" != "$(pwd -P)/venv" ]; then
            _VENV_NAME=$(basename `pwd`)
            echo Activating virtualenv \"$_VENV_NAME\"...
            VIRTUAL_ENV_DISABLE_PROMPT=1
            source venv/bin/activate
            _OLD_VIRTUAL_PS1="$PS1"
            PS1="($_VENV_NAME)$PS1"
            export PS1
        fi
    fi
}

precmd() { _virtualenv_auto_activate }

# OPAM configuration
#[[ ! -r /home/anton/.opam/opam-init/init.zsh ]] || source /home/anton/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# git dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# git subrepo completion
fpath=('~/apps/git-subrepo/share/zsh-completion' $fpath)

# anaconda
# source /opt/anaconda/bin/activate

# fix anaconda's python taking precedence of system python
export PATH=/usr/bin:$PATH

# mv include hidden files
setopt dotglob

# hub
eval "$(hub alias -s)"

# xclip
alias setclip="xclip -selection c"
alias getclip="xclip -selection c -o"

# scala sbt-web
# https://www.playframework.com/documentation/2.7.x/AssetsOverview
export SBT_OPTS="-Dsbt.jse.engineType=Node"

# Rust
export PATH=$HOME/.cargo/bin:$PATH

# Wasienv
export WASIENV_DIR="/home/anton/.wasienv"
[ -s "$WASIENV_DIR/wasienv.sh" ] && source "$WASIENV_DIR/wasienv.sh"

# Wasmer
export WASMER_DIR="/home/anton/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"

# Add default node to path
# export PATH=~/.nvm/versions/node/v12.16.1/bin:$PATH

# Load NVM
export NVM_DIR=~/.nvm
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh" --no-use

export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"
