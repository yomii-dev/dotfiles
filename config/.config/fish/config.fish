# Set default editor
export EDITOR=nvim

function fish_greeting
    # Leave this empty to disable the message
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# For shell tool thingies
zoxide init fish | source
fzf --fish | source
thefuck --alias | source

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# Completions
tailscale completion fish | source

# Aliases
abbr -a ls "eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
abbr -a uu "sudo pacman -Syu && yay -Syu && flatpak update"
abbr -a t "tuxedo todo.txt"
abbr -a ytmp4 "yt-dlp -f \"bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4]\" --paths ~/Videos/"

# Run fastfetch ONLY on alacritty
if test "$TERM" = alacritty; or test "$TERM" = xterm-ghostty
    fastfetch
end

# Vim mode for fish
fish_vi_key_bindings

function __complete_syncthing
    set -lx COMP_LINE (commandline -cp)
    test -z (commandline -ct)
    and set COMP_LINE "$COMP_LINE "
    /usr/bin/syncthing
end
complete -f -c syncthing -a "(__complete_syncthing)"
