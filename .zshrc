# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd beep notify
bindkey -v

# kitty ssh fix
[[ "$TERM" == "xterm-kitty" ]] && alias ssh="TERM=xterm-256color ssh"

# The following lines were added by compinstall
zstyle :compinstall filename "/$HOME/.zshrc"

autoload -Uz compinit
compinit


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(git
	 zsh-syntax-highlighting
	 zsh-autosuggestions
	 extract
	 wd
	 fzf
	 sudo
	)


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# # >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('${HOME}/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "${HOME}/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "${HOME}/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="${HOME}/miniconda3/bin:$PATH"
#     fi
# fi
# export LD_LIBRARY_PATH="${HOME}/miniconda3/envs/rlgpu/lib:$LD_LIBRARY_PATH"
# unset __conda_setup
# sudo mv $CONDA_PREFIX/bin/clear $CONDA_PREFIX/bin/clear_old
# export TERMINFO="/usr/share/terminfo"
# alias clear="TERM=xterm /usr/bin/clear"
# <<< conda initialize <<<

export MANPAGER="nvim +Man!"
alias cls="clear"
alias v="nvim"
alias sz="source ~/.zshrc"
alias ez="nvim ~/.zshrc"
alias f=". ranger"

alias cob="conda activate base"
alias cel="conda env list"
alias cor="conda activate rlgpu"
alias cod="conda deactivate"
alias ubu="sudo chroot /srv/chroot/ubuntu-20.04-arm64 /bin/bash"


# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export MANPAGER="nvim +Man!"


#Cargo and Rust
. "$HOME/.cargo/env"

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh
export PATH=$PATH:"$HOME/.config/zig-aarch64-macos-0.16.0-dev.13+1594c8055"


# --- Oh-my-posh Setup ---
export PATH="$PATH:$HOME/.local/bin"
# eval "$(oh-my-posh init zsh --config ~/.config/nvim/temp/omp_themes/atomic.omp.json)"
# eval "$(oh-my-posh init zsh --config ~/.config/nvim/temp/omp_themes/negligible.omp.json)"
# eval "$(oh-my-posh init zsh --config ~/.config/nvim/temp/omp_themes/kali.omp.json)"
# eval "$(oh-my-posh init zsh --config ~/.config/nvim/temp/omp_themes/multiverse-neon.omp.json)"
# eval "$(oh-my-posh init zsh --config ~/.config/nvim/temp/omp_themes/hunk.omp.json)"
# eval "$(oh-my-posh init zsh --config ~/.config/nvim/temp/omp_themes/huvix.omp.json)"
eval "$(oh-my-posh init zsh --config ~/.config/nvim/temp/omp_themes/nordtron.omp.json)"
# eval "$(oh-my-posh init zsh --config ~/.config/nvim/temp/omp_themes/darkblood.omp.json)"
# eval "$(oh-my-posh init zsh --config ~/.config/nvim/temp/omp_themes/emodipt-extend.omp.json)"
# eval "$(oh-my-posh init zsh --config ~/.config/nvim/temp/omp_themes/powerlevel10k_classic.omp.json)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# History Grep: Ctrl+R
source <(fzf --zsh)


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
