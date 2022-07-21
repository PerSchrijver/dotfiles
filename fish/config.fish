# ~/.config/fish/config.fish

starship init fish | source

set text_editor vim

# Faust CTF alias
alias atk=/home/per/Downloads/ataka-player-cli/cli.py

alias vim "nvim -c \"normal Mzt\""
alias ll "exa -l -g --icons"
alias lla "ll -a"
alias config "/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
config config --local status.showUntrackedFiles no
alias i "sudo apt install"
alias diff "diff --color --side-by-side"
alias bat batcat
alias s "python3 -i ~/scripts/python_scratchpad.py"
alias gitdiff "ydiff -s -w0"
alias p instantiate_project
function instantiate_project
   ~/Templates/instantiate_project $argv[1..-1] && cd $argv[2]
end

set -g -x FISHCONFIG ~/.config/fish/config.fish
set -g -x STARSHIPCONFIG ~/.config/starship.toml
set -g -x I3CONFIG ~/.config/i3/config
set -g -x VIMCONFIG ~/.config/nvim/init.vim
set -g -x TMUXCONFIG ~/.tmux.conf
set -g -x SSHCONFIG ~/.ssh/config

function fishconfig
    $text_editor $FISHCONFIG
    source $FISHCONFIG
end
function starshipconfig
    $text_editor $STARSHIPCONFIG
    starship init fish | source
end
function i3config
    $text_editor $STARSHIPCONFIG
    i3-msg reload > /dev/null
end
function vimconfig
    $text_editor $VIMCONFIG
end
function tmuxconfig
    $text_editor $TMUXCONFIG
    tmux source $TMUXCONFIG
end
function sshconfig
    $text_editor $SSHCONFIG
end

function fish_user_key_bindings
    bind \cr peco_select_history # Ctrl-r
    bind \cg peco_select_file # Ctrl-f
    bind -k nul forward-char
    bind \cy do_thing
end

