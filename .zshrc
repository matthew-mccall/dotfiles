# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/Zsh/antigen.zsh

antigen use oh-my-zsh

antigen bundle colorize
antigen bundle gitignore
# antigen bundle jeffreytse/zsh-vi-mode
antigen bundle zdharma-continuum/fast-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle marlonrichert/zsh-autocomplete@main

antigen theme romkatv/powerlevel10k

antigen apply

# Make `Enter` submit the command line straight from the menu
bindkey -M menuselect '\r' .accept-line

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="$PATH:/Users/mmccall/Zsh"
export PATH="$PATH:/Users/mmccall/CEDev/bin"
export PATH="$PATH:/Users/mmccall/dafny"
export PATH="$PATH:/Applications/CMake.app/Contents/bin"
export PATH="$PATH:/Users/mmccall/Library/Application Support/Steam/steamapps/common/Blender/Blender.app/Contents/MacOS"
export PATH="$PATH:/Applications/Inkscape.app/Contents/MacOS"

export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

if [ -x "$(which zoxide)" ];
then
    function cd () {
        __zoxide_z "$@"
    }
    eval "$(zoxide init zsh --no-cmd)"
fi
