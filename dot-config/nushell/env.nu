# Nushell Environment Config File
#
# version = "0.85.0"

def create_left_prompt [] {
    let home =  $nu.home-path

    let dir = ([
        ($env.PWD | str substring 0..($home | str length) | str replace $home "~"),
        ($env.PWD | str substring ($home | str length)..)
    ] | str join)

    let path_color = (if (is-admin) { ansi red_bold } else { ansi green_bold })
    let separator_color = (if (is-admin) { ansi light_red_bold } else { ansi light_green_bold })
    let path_segment = $"($path_color)($dir)"

    $path_segment | str replace --all (char path_sep) $"($separator_color)/($path_color)"
}

def create_right_prompt [] {
    # create a right prompt in magenta with green separators and am/pm underlined
    let time_segment = ([
        (ansi reset)
        (ansi magenta)
        (date now | format date '%x %X %p') # try to respect user's locale
    ] | str join | str replace --regex --all "([/:])" $"(ansi green)${1}(ansi magenta)" |
        str replace --regex --all "([AP]M)" $"(ansi magenta_underline)${1}")

    let last_exit_code = if ($env.LAST_EXIT_CODE != 0) {([
        (ansi rb)
        ($env.LAST_EXIT_CODE)
    ] | str join)
    } else { "" }

    ([$last_exit_code, (char space), $time_segment] | str join)
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = {|| create_left_prompt }
# FIXME: This default is not implemented in rust code as of 2023-09-08.
$env.PROMPT_COMMAND_RIGHT = {|| create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = {|| "> " }
$env.PROMPT_INDICATOR_VI_INSERT = {|| ": " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "> " }
$env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

# Directories to search for scripts when calling source or use
$env.NU_LIB_DIRS = [
    # FIXME: This default is not implemented in rust code as of 2023-09-06.
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
]

# Directories to search for plugin binaries when calling register
$env.NU_PLUGIN_DIRS = [
    # FIXME: This default is not implemented in rust code as of 2023-09-06.
    ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

$env.PATH = ($env.PATH | split row (char esep) | prepend $"($env.HOME)/.cargo/bin" | uniq)

let home_local_bin_path = $"($env.HOME)/.local/bin"

if ($home_local_bin_path | path exists) {
    $env.PATH = ($env.PATH | split row (char esep) | prepend $home_local_bin_path | uniq)
}

$env.EDITOR = "nvim"
$env.BAT_THEME = "Catppuccin Macchiato"

$env.DELTA_FEATURES = "+side-by-side line-numbers"

$env.STARSHIP_CONFIG = $"($env.HOME)/.config/nushell/starship_theme.toml"
mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu
zoxide init nushell | save -f ~/.zoxide.nu
$env.FZF_DEFAULT_OPTS = "
--color=bg+:\#363a4f,bg:\#24273a,spinner:\#f4dbd6,hl:\#ed8796
--color=fg:\#cad3f5,header:\#ed8796,info:\#c6a0f6,pointer:\#f4dbd6
--color=marker:\#b7bdf8,fg+:\#cad3f5,prompt:\#c6a0f6,hl+:\#ed8796
--color=selected-bg:\#494d64
--color=border:\#363a4f,label:\#cad3f5
"

const local_env_path = "~/.config/nushell/local_env.nu"

if ($local_env_path | path exists) {
    source $local_env_path
}
