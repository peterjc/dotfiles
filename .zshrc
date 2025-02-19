# Ghostty by default binds ctrl+left and ctrl+right to esc b and f
# which was used by zsh for left/right jumping at the prompt.
# Without this, I see ;5C and ;5D in red appear instead.
bindkey ";5C" forward-word
bindkey ";5D" backward-word

# And since the default with alt+left and alt+right is useless, do same:
bindkey ";3C" forward-word
bindkey ";3D" backward-word

alias dotfiles-git='git --git-dir=$HOME/repositories/dotfiles.git/ --work-tree=$HOME'

alias emacs="emacs -nw"
export EDITOR="nano"
alias tsv="xsv table -p 1 -d '\t'"
alias git-log="serie"

case "$OSTYPE" in
darwin*)
    # ...
    alias lsusb="system_profiler SPUSBDataType"
    # alias md5sum='md5 -r'
    ;;
linux*)
    # ...
    ;;
dragonfly* | freebsd* | netbsd* | openbsd*)
    # ...
    ;;
esac

if [ -d $HOME/.cargo ]; then
    export PATH=$HOME/bin:$HOME/.cargo/bin:$PATH
fi

if [ ! -d $HOME/bin/ ]; then
    mkdir $HOME/bin
    echo "Your ~/bin is empty!"
fi
export PATH=$HOME/bin:$PATH

if [ -f $HOME/.config/secrets.sh ]; then
    source $HOME/.config/secrets.sh
else
    echo "Missing ~/.config/secrets.sh for keys and tokens!"
fi

# make tab autocomplete more like bash
setopt BEEP NO_AUTOLIST BASH_AUTOLIST NO_MENUCOMPLETE

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# Enable colors for available commands
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'

# Oh-my-posh Setup
#eval "$(oh-my-posh init zsh --config .config/ohmyposh/default.omp.json)"

if [ -d $HOME/.zsh/pure/ ]; then
    # pure prompt setup
    fpath+=($HOME/.zsh/pure)
    autoload -U promptinit
    promptinit
    zstyle :prompt:pure:git:stash show yes
    prompt pure
else
    echo "Missing ~/.zsh/pure/ from https://github.com/sindresorhus/pure"
fi

# enable git autocomplete, see
# https://git-scm.com/book/en/v2/Appendix-A%3A-Git-in-Other-Environments-Git-in-Zsh
autoload -Uz compinit && compinit

if [ -d $HOME/.zsh/per-directory-history/ ]; then
    # Jim Hester's per-directory-history (which still records the global history)
    # Not using https://github.com/ericfreese/zsh-cwd-history.git as it does
    # not fill the global history too, so won't help auto-suggestions
    source ~/.zsh/per-directory-history/per-directory-history.zsh
else
    echo "Missing ~/.zsh/per-directory-history/ from https://github.com/jimhester/per-directory-history"
fi

if [ -d $HOME/.zsh/zsh-autosuggestions/ ]; then
    # Import auto-suggestions (which draws on the global history)
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
    # ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"
else
    echo "Missing ~/.zsh/zsh-autosuggestions/ from https://github.com/zsh-users/zsh-autosuggestions"
fi

if [ -d $HOME/.zsh/zsh-syntax-highlighting/ ]; then
    # Import Zsh Syntax Highlighting
    source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    # Adjusted Zsh syntax highlighting colors
    #ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=007
    #ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=006
    #ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=006
    #ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=008
    #ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=008
    #ZSH_HIGHLIGHT_STYLES[comment]=fg=008
    #ZSH_HIGHLIGHT_STYLES[function]=fg=006
    #ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=005
    #ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=005
    #ZSH_HIGHLIGHT_STYLES[redirection]=fg=005
else
    echo "Missing ~/.zsh/zsh-syntax-highlighting/ from https://github.com/zsh-users/zsh-syntax-highlighting"
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniforge3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
