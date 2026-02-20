# Nord Fish color theme
# Auto-loaded from conf.d/

# --------------------
# Syntax highlighting
# --------------------
set -U fish_color_command        brcyan        # Nord Frost
set -U fish_color_keyword        brmagenta     # Nord Aurora
set -U fish_color_param          brwhite
set -U fish_color_quote          bryellow
set -U fish_color_redirection    brcyan
set -U fish_color_operator       brcyan
set -U fish_color_escape         brgreen
set -U fish_color_end            brcyan

# --------------------
# Feedback / UI
# --------------------
set -U fish_color_error          brred --bold
set -U fish_color_comment        brblack
set -U fish_color_autosuggestion brblack
set -U fish_color_valid_path     brgreen --underline
set -U fish_color_cwd            brcyan
set -U fish_color_cwd_root       brred --bold
set -U fish_color_user           brgreen
set -U fish_color_host           brblue

# --------------------
# Pager / completions
# --------------------
set -U fish_pager_color_prefix      brcyan --bold
set -U fish_pager_color_completion  brwhite
set -U fish_pager_color_description brblack
set -U fish_pager_color_progress    brblack
set -U fish_pager_color_selected_background --background=brblack
