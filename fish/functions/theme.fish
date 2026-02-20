function theme
    set theme_name $argv[1]

    if test -z "$theme_name"
        echo "Usage: theme <name>"
        echo "Available themes:"
        ls ~/.config/fish/themes | sed 's/.fish$//'
        return 1
    end

    set theme_file ~/.config/fish/themes/$theme_name.fish

    if not test -f $theme_file
        echo "Theme '$theme_name' not found."
        return 1
    end

    # Clear existing fish colors
    for var in (set -n | string match 'fish_color_*')
        set -eU $var
    end

    # Load new theme
    source $theme_file

    echo "Switched to theme: $theme_name"
end
