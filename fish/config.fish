source /usr/share/cachyos-fish-config/cachyos-config.fish

# Disable fish greeting
set -g fish_greeting

# Editor
set -gx EDITOR nvim
set -gx VISUAL nvim

# Pager colors (less)
set -gx LESS_TERMCAP_mb \e'[1;31m'
set -gx LESS_TERMCAP_md \e'[1;36m'
set -gx LESS_TERMCAP_me \e'[0m'
set -gx LESS_TERMCAP_se \e'[0m'
set -gx LESS_TERMCAP_so \e'[01;44;33m'
set -gx LESS_TERMCAP_ue \e'[0m'
set -gx LESS_TERMCAP_us \e'[1;32m'

# Paths
fish_add_path ~/bin
fish_add_path ~/.local/bin
# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end
