
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

### zinit: Plugins {{{
zinit light-mode for \
    zdharma/history-search-multi-word

# zdharma/fast-syntax/highlighting
# zsh-autosuggestions
# zsh-completions
zinit wait lucid for \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
        zdharma/fast-syntax-highlighting \
    blockf \
        zsh-users/zsh-completions \
    atload"!_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions

# zdharma/history-search-multi-word
zstyle ":history-search-multi-word" page-size "11"
zinit ice wait"1" lucid
zinit load zdharma/history-search-multi-word

# starship/starship
zinit ice from"gh-r" sbin"starship"
zinit light starship/starship

# sharkdp/fd
zinit wait"1" lucid from"gh-r" as"null" \
  sbin"**/fd" for @sharkdp/fd

# sharkdp/bat
zinit wait"1" lucid from"gh-r" as"null" \
  atload"alias cat=bat" \
  sbin"**/bat" for @sharkdp/bat

# Peltoche/lsd
zinit wait"1" lucid from"gh-r" as"null" \
  atload"alias ls=lsd" \
  sbin"**/lsd" for @Peltoche/lsd \

# BurntSushi/ripgrep
zinit wait"1" lucid from"gh-r" as"null" \
  sbin"**/rg" for @BurntSushi/ripgrep \

# junegunn/fzf-bin
zinit wait"1" lucid from"gh-r" as"null" \
  sbin"fzf" for @junegunn/fzf-bin

# neovim/neovim
zinit wait"1" lucid from"gh-r" ver"latest" as"null" \
  atload"alias vi=nvim" \
  sbin"**/bin/nvim" for @neovim/neovim

zinit snippet "${HOME}/.zsh/rc/aliases.zsh"
zinit snippet "${HOME}/.zsh/rc/options.zsh"

### }}}

eval "$(starship init zsh)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

