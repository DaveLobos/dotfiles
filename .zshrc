WORDCHARS=${WORDCHARS/\//}
WORDCHARS=${WORDCHARS/\./}
WORDCHARS=${WORDCHARS/\-/}
WORDCHARS=${WORDCHARS/\_/}

zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/home/dave/.zshrc'

autoload -Uz compinit
compinit

PROMPT='%F{#00CCCC}%c $ %f'

# History

HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt inc_append_history
setopt share_history

unsetopt beep

alias ls='ls -lah --color=auto'
alias emacs='emacs -nw'

export EDITOR="emacs -nw"

# ........................................................................ PATH

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.local/emacs/bin" ] ; then
    PATH="$HOME/.local/emacs/bin:$PATH"
fi

if [ -d "$HOME/.local/node/bin" ] ; then
    PATH="$HOME/.local/node/bin:$PATH"
fi

if [ -d "$HOME/.local/go/bin" ] ; then
    PATH="$HOME/.local/go/bin:$PATH"
fi

if [ -d "$HOME/go/bin" ] ; then
    PATH="$HOME/go/bin:$PATH"
fi

if [ -d "$HOME/.local/elixir/bin" ] ; then
    PATH="$HOME/.local/elixir/bin:$PATH"
fi

if [ -d "$HOME/.local/zig" ] ; then
    PATH="$HOME/.local/zig:$PATH"
fi

if [ -d "$HOME/.duckdb/cli/latest" ] ; then
    PATH="$PATH:$HOME/.duckdb/cli/latest"
fi

. "$HOME/.cargo/env"

export PNPM_HOME='/home/dave/.local/share/pnpm'

case ":$PATH:" in
  ":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
