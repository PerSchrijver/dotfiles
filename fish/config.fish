# Fish config

export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:/home/per/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"
export PATH="/home/per/.nimble/bin:$PATH"
export PATH="/home/per/.cargo/bin:$PATH"

## WSL specific
if uname -r | grep microsoft-standard-WSL > /dev/null
  export PATH="/mnt/c/Users/persc/AppData/Local/Programs/Microsoft VS Code/bin:$PATH"

  export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0.0
  export LIBGL_ALWAYS_INDIRECT=0
end

function fish_greeting # INTERACTIVE ONLY CONFIGURATION
    # Temporary configs

    # Text editor
    set -g -x TEXT_EDITOR vim
    alias vim "nvim -c \"normal M\""

    # Premium shit
    starship init fish | source
    alias i "sudo apt install"
    alias ll "exa -l -g --icons"
    alias lla "ll -a"
    alias diff "diff --color --side-by-side"
    alias bat "batcat --paging=never"
    alias p instantiate_project
    alias dus "show_sorted_filesizes"
    alias tree "tree -C"
    alias e "explorer"

    # Git aliases
    alias gitdiff "ydiff -s -w0"
    alias gc "git commit -m"
    alias ga "git add"
    alias gap "ga -p"
    alias gaa "ga ."
    alias gac "gaa&&gc"
    alias gs "git status"
    alias gd "gitdiff"
    alias gds "gd --staged"
    alias gcc "git clone"

    # Config locations
    set -g -x FISHCONFIG ~/.config/fish/config.fish
    set -g -x STARSHIPCONFIG ~/.config/starship.toml
    set -g -x I3CONFIG ~/.config/i3/config
    set -g -x VIMCONFIG ~/.config/nvim/init.vim
    set -g -x TMUXCONFIG ~/.tmux.conf
    set -g -x SSHCONFIG ~/.ssh/config

    # Custom functions
    function instantiate_project
       ~/Templates/instantiate_project $argv[1..-1] && cd $argv[2]
    end
    function temp
        cd (mktemp -d)
    end
    function explorer --argument-names 'path'
        # Default for path is current directory
        if test -n "$path"
        else
            set path "."
        end

        # Switch between nautilus and windows explorer
        if uname -r | grep microsoft-standard-WSL > /dev/null
            /mnt/c/Windows/explorer.exe (wslpath -w $path)
        else
            nautilus $path >/dev/null 2>/dev/null &
        end
    end

    function show_sorted_filesizes --argument-names 'filename'
        if test -n "$filename"
            ls -d $filename/* | xargs du -csh | sort -h
        else
            du -csh * | sort -h
        end
    end
    function codez --argument-names 'zpath'
        if test -n "$zpath"
            z $zpath
        end
        code .
        exit
    end
    function fishconfig
        $TEXT_EDITOR $FISHCONFIG
        source $FISHCONFIG
        fish_greeting >/dev/null
    end
    function starshipconfig
        $TEXT_EDITOR $STARSHIPCONFIG
        starship init fish | source
    end
    function i3config
        $TEXT_EDITOR $STARSHIPCONFIG
        i3-msg reload > /dev/null
    end
    function vimconfig
        $TEXT_EDITOR $VIMCONFIG
    end
    function tmuxconfig
        $TEXT_EDITOR $TMUXCONFIG
        tmux source $TMUXCONFIG
    end
    function sshconfig
        $TEXT_EDITOR $SSHCONFIG
    end

    # Fish keybinds
    function fish_user_key_bindings
        bind \cr peco_select_history # Ctrl-r
        bind \cg peco_select_file # Ctrl-f
        bind -k nul forward-char
    end
end # INTERACTIVE ONLY CONFIGURATION

