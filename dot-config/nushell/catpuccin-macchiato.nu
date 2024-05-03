const color_palette = {
    rosewater: "#f4dbd6"
    flamingo: "#f0c6c6"
    pink: "#f5bde6"
    mauve: "#c6a0f6"
    red: "#ed8796"
    maroon: "#ee99a0"
    peach: "#f5a97f"
    yellow: "#eed49f"
    green: "#a6da95"
    teal: "#8bd5ca"
    sky: "#91d7e3"
    sapphire: "#7dc4e4"
    blue: "#8aadf4"
    lavender: "#b7bdf8"
    text: "#cad3f5"
    subtext1: "#b8c0e0"
    subtext0: "#a5adcb"
    overlay2: "#939ab7"
    overlay1: "#8087a2"
    overlay0: "#6a738d"
    surface2: "#5b6078"
    surface1: "#494d64"
    surface0: "#363a4f"
    base: "#1e1e2e"
    mantle: "#1e2030"
    crust: "#181926"
}

export def main [] { return {
    separator: $color_palette.overlay0
    leading_trailing_space_bg: { attr: "n" }
    header: { fg: $color_palette.blue attr: "b" }
    empty: $color_palette.lavender
    bool: $color_palette.lavender
    int: $color_palette.peach
    duration: $color_palette.text
    filesize: {|e|
          if $e < 1mb {
            $color_palette.green
        } else if $e < 100mb {
            $color_palette.yellow
        } else if $e < 500mb {
            $color_palette.peach
        } else if $e < 800mb {
            $color_palette.maroon
        } else if $e > 800mb {
            $color_palette.red
        }
    }
    date: {|| (date now) - $in |
        if $in < 1hr {
            $color_palette.green
        } else if $in < 1day {
            $color_palette.yellow
        } else if $in < 3day {
            $color_palette.peach
        } else if $in < 1wk {
            $color_palette.maroon
        } else if $in > 1wk {
            $color_palette.red
        }
    }
    range: $color_palette.text
    float: $color_palette.text
    string: $color_palette.text
    nothing: $color_palette.text
    binary: $color_palette.text
    cellpath: $color_palette.text
    row_index: { fg: $color_palette.mauve attr: "b" }
    record: $color_palette.text
    list: $color_palette.text
    block: $color_palette.text
    hints: $color_palette.overlay1
    search_result: { fg: $color_palette.red bg: $color_palette.text }

    shape_and: { fg: $color_palette.pink attr: "b" }
    shape_binary: { fg: $color_palette.pink attr: "b" }
    shape_block: { fg: $color_palette.blue attr: "b" }
    shape_bool: $color_palette.teal
    shape_custom: $color_palette.green
    shape_datetime: { fg: $color_palette.teal attr: "b" }
    shape_directory: $color_palette.teal
    shape_external: $color_palette.teal
    shape_externalarg: { fg: $color_palette.green attr: "b" }
    shape_filepath: $color_palette.teal
    shape_flag: { fg: $color_palette.blue attr: "b" }
    shape_float: { fg: $color_palette.pink attr: "b" }
    shape_garbage: { fg: $color_palette.text bg: $color_palette.red attr: "b" }
    shape_globpattern: { fg: $color_palette.teal attr: "b" }
    shape_int: { fg: $color_palette.pink attr: "b" }
    shape_internalcall: { fg: $color_palette.teal attr: "b" }
    shape_list: { fg: $color_palette.teal attr: "b" }
    shape_literal: $color_palette.blue
    shape_match_pattern: $color_palette.green
    shape_matching_brackets: { attr: "u" }
    shape_nothing: $color_palette.teal
    shape_operator: $color_palette.peach
    shape_or: { fg: $color_palette.pink attr: "b" }
    shape_pipe: { fg: $color_palette.pink attr: "b" }
    shape_range: { fg: $color_palette.peach attr: "b" }
    shape_record: { fg: $color_palette.teal attr: "b" }
    shape_redirection: { fg: $color_palette.pink attr: "b" }
    shape_signature: { fg: $color_palette.green attr: "b" }
    shape_string: $color_palette.green
    shape_string_interpolation: { fg: $color_palette.teal attr: "b" }
    shape_table: { fg: $color_palette.blue attr: "b" }
    shape_variable: $color_palette.pink

    background: $color_palette.base
    foreground: $color_palette.text
    cursor: $color_palette.blue
}}
