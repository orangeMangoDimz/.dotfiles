# config.nu
#
# Installed by:
# version = "0.113.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

# Compatibility layer for zsh-era workflow.
let extraPaths = [
    $"($env.HOME)/.local/bin"
    $"($env.HOME)/.opencode/bin"
    $"($env.HOME)/go/bin"
    $"($env.HOME)/.bun/bin"
    $"($env.HOME)/.nvim/usr/bin"
    $"($env.HOME)/.config/composer/vendor/bin"
    $"($env.HOME)/Android/Sdk/emulator"
    $"($env.HOME)/Android/Sdk/platform-tools"
    $"($env.HOME)/.spicetify"
]

$env.PATH = (
    (
        if (($env.PATH | describe) =~ '^list<') {
            $env.PATH
        } else {
            $env.PATH | split row (char esep)
        }
    )
    | append ($extraPaths | where {|p| $p | path exists })
    | uniq
)

$env.EDITOR = "nvim"

let catppuccinMocha = {
    rosewater: "#f5e0dc"
    flamingo: "#f2cdcd"
    pink: "#f5c2e7"
    mauve: "#cba6f7"
    red: "#f38ba8"
    maroon: "#eba0ac"
    peach: "#fab387"
    yellow: "#f9e2af"
    green: "#a6e3a1"
    teal: "#94e2d5"
    sky: "#89dceb"
    sapphire: "#74c7ec"
    blue: "#89b4fa"
    lavender: "#b4befe"
    text: "#cdd6f4"
    subtext1: "#bac2de"
    subtext0: "#a6adc8"
    overlay2: "#9399b2"
    overlay1: "#7f849c"
    overlay0: "#6c7086"
    surface2: "#585b70"
    surface1: "#45475a"
    surface0: "#313244"
    base: "#1e1e2e"
    mantle: "#181825"
    crust: "#11111b"
}

$env.config.show_banner = false
$env.config.highlight_resolved_externals = true
$env.config.render_right_prompt_on_last_line = false
$env.config.table.mode = "compact"
$env.config.table.index_mode = "never"
$env.config.table.padding.left = 0
$env.config.table.padding.right = 0
$env.config.table.trim = { methodology: "wrapping", wrapping_try_keep_words: true }

$env.config.color_config = {
    foreground: $catppuccinMocha.text
    background: $catppuccinMocha.base
    cursor: $catppuccinMocha.rosewater

    separator: $catppuccinMocha.overlay0
    leading_trailing_space_bg: { bg: $catppuccinMocha.surface1 }
    header: { fg: $catppuccinMocha.blue attr: "b" }
    empty: $catppuccinMocha.overlay1
    bool: $catppuccinMocha.teal
    int: $catppuccinMocha.peach
    filesize: $catppuccinMocha.sky
    duration: $catppuccinMocha.yellow
    datetime: $catppuccinMocha.lavender
    range: $catppuccinMocha.yellow
    float: $catppuccinMocha.peach
    string: $catppuccinMocha.green
    nothing: $catppuccinMocha.overlay1
    binary: $catppuccinMocha.sapphire
    binary_null_char: { fg: $catppuccinMocha.red attr: "b" }
    binary_printable: { fg: $catppuccinMocha.green attr: "b" }
    binary_whitespace: { fg: $catppuccinMocha.yellow attr: "b" }
    binary_ascii_other: { fg: $catppuccinMocha.mauve attr: "b" }
    binary_non_ascii: { fg: $catppuccinMocha.maroon attr: "b" }
    cell-path: $catppuccinMocha.subtext0
    row_index: { fg: $catppuccinMocha.lavender attr: "b" }
    record: $catppuccinMocha.text
    list: $catppuccinMocha.text
    closure: { fg: $catppuccinMocha.mauve attr: "b" }
    glob: { fg: $catppuccinMocha.teal attr: "b" }
    block: $catppuccinMocha.text
    hints: $catppuccinMocha.overlay0
    search_result: { fg: $catppuccinMocha.crust bg: $catppuccinMocha.yellow attr: "b" }

    shape_binary: { fg: $catppuccinMocha.peach attr: "b" }
    shape_block: { fg: $catppuccinMocha.blue attr: "b" }
    shape_bool: $catppuccinMocha.teal
    shape_closure: { fg: $catppuccinMocha.mauve attr: "b" }
    shape_custom: $catppuccinMocha.green
    shape_datetime: { fg: $catppuccinMocha.lavender attr: "b" }
    shape_directory: $catppuccinMocha.blue
    shape_external: $catppuccinMocha.sky
    shape_external_resolved: { fg: $catppuccinMocha.green attr: "b" }
    shape_externalarg: { fg: $catppuccinMocha.green attr: "b" }
    shape_filepath: $catppuccinMocha.blue
    shape_flag: { fg: $catppuccinMocha.mauve attr: "b" }
    shape_float: { fg: $catppuccinMocha.peach attr: "b" }
    shape_garbage: { fg: $catppuccinMocha.crust bg: $catppuccinMocha.red attr: "b" }
    shape_glob_interpolation: { fg: $catppuccinMocha.teal attr: "b" }
    shape_globpattern: { fg: $catppuccinMocha.teal attr: "b" }
    shape_int: { fg: $catppuccinMocha.peach attr: "b" }
    shape_internalcall: { fg: $catppuccinMocha.blue attr: "b" }
    shape_keyword: { fg: $catppuccinMocha.mauve attr: "b" }
    shape_list: { fg: $catppuccinMocha.sky attr: "b" }
    shape_literal: $catppuccinMocha.yellow
    shape_match_pattern: $catppuccinMocha.green
    shape_matching_brackets: { fg: $catppuccinMocha.rosewater attr: "u" }
    shape_nothing: $catppuccinMocha.overlay1
    shape_operator: $catppuccinMocha.yellow
    shape_pipe: { fg: $catppuccinMocha.mauve attr: "b" }
    shape_range: { fg: $catppuccinMocha.yellow attr: "b" }
    shape_raw_string: $catppuccinMocha.green
    shape_record: { fg: $catppuccinMocha.sky attr: "b" }
    shape_redirection: { fg: $catppuccinMocha.mauve attr: "b" }
    shape_signature: { fg: $catppuccinMocha.green attr: "b" }
    shape_string: $catppuccinMocha.green
    shape_string_interpolation: { fg: $catppuccinMocha.teal attr: "b" }
    shape_table: { fg: $catppuccinMocha.blue attr: "b" }
    shape_variable: $catppuccinMocha.lavender
    shape_vardecl: $catppuccinMocha.lavender
}

$env.STARSHIP_SHELL = "nu"
$env.STARSHIP_SESSION_KEY = (random chars -l 16)
$env.STARSHIP_CONFIG = ("~/.config/starship.toml" | path expand)

$env.PROMPT_MULTILINE_INDICATOR = (
    ^/usr/local/bin/starship prompt --continuation
)

# Keep prompt character from starship's [character] module.
$env.PROMPT_INDICATOR = ""

$env.PROMPT_COMMAND = {||
    (
        ^/usr/local/bin/starship prompt
            --cmd-duration ($env.CMD_DURATION_MS? | default 0)
            $"--status=($env.LAST_EXIT_CODE)"
            --terminal-width (term size).columns
    )
}

$env.PROMPT_COMMAND_RIGHT = {||
    (
        ^/usr/local/bin/starship prompt
            --right
            --cmd-duration ($env.CMD_DURATION_MS? | default 0)
            $"--status=($env.LAST_EXIT_CODE)"
            --terminal-width (term size).columns
    )
}

$env.config = ($env.config | merge { render_right_prompt_on_last_line: true })

$env.TRANSIENT_PROMPT_COMMAND = {||
    (
        ^/usr/local/bin/starship prompt
            --cmd-duration ($env.CMD_DURATION_MS? | default 0)
            $"--status=($env.LAST_EXIT_CODE)"
            --terminal-width (term size).columns
    )
}
$env.TRANSIENT_PROMPT_INDICATOR = ""
$env.TRANSIENT_PROMPT_INDICATOR_VI_INSERT = ""
$env.TRANSIENT_PROMPT_INDICATOR_VI_NORMAL = ""
$env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = ""
$env.TRANSIENT_PROMPT_COMMAND_RIGHT = ""

def --wrapped nvim [...rest] {
    let preferredNvim = $"($env.HOME)/.local/bin/nvim"
    if ($preferredNvim | path exists) {
        run-external $preferredNvim ...$rest
    } else {
        run-external nvim ...$rest
    }
}

def --wrapped claude [...rest] {
    run-external "claude" "--dangerously-skip-permissions" ...$rest
}

def --wrapped cw [...rest] {
    let userClaudeConfig = ("~/.claude.json" | path expand)
    let workHome = "/home/orangemango/.claude-work-home"
    let workClaudeConfig = $"($workHome)/.claude.json"

    if not ($userClaudeConfig | path exists) {
        error make { msg: $"Missing source config: ($userClaudeConfig)" }
    }
    if not ($workClaudeConfig | path exists) {
        error make { msg: $"Missing work config: ($workClaudeConfig)" }
    }

    let sourceConfig = (open $userClaudeConfig)
    let workConfig = (open $workClaudeConfig)
    let mergedConfig = ($workConfig | upsert mcpServers ($sourceConfig.mcpServers? | default {}))
    $mergedConfig | to json --indent 2 | save --force $workClaudeConfig

    with-env { HOME: $workHome } {
        run-external "claude" "--dangerously-skip-permissions" ...$rest
    }
}

alias cls = clear
alias ls = lsd -a --color=always --icon=always --classify
alias disk_space = df -h /
alias lzg = lazygit
alias lzd = lazydocker
alias d = docker
alias dc = docker container
alias di = docker image
alias dv = docker volume
alias dn = docker network
alias dcu = docker compose up
alias dcd = docker compose down

alias gst = git status
alias gco = git checkout
alias gci = git commit
alias gbr = git branch
alias gr = git restore
alias gp = git push
alias gpo = git push origin
alias gpf = git push --force-with-lease
alias gpl = git pull
alias gplo = git pull origin
alias gsa = git stash apply
alias gsc = git stash clear
alias gsd = git stash drop
alias gsl = git stash list
alias gsp = git stash pop
alias gss = git stash save
alias ga = git add
alias gaa = git add --all
alias gcm = git commit -m
alias gcam = git commit -am
alias gamend = git commit --amend
alias gundo = git reset HEAD~1 --mixed
alias gbd = git branch -d
alias gbD = git branch -D
alias gm = git merge
alias grb = git rebase
alias gd = git diff
alias gds = git diff --staged
alias gra = git remote add
alias grr = git remote remove
alias grv = git remote -v
alias gcp = git cherry-pick
alias glg = git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit

alias nrd = npm run dev
alias nrb = npm run build
alias py38 = python3.8
alias py311 = python3.11

def --env pdocs [] { cd ~/Documents }
def --env pdowns [] { cd ~/Downloads }
def --env pwork [] { cd ~/Documents/workspace }
def --env pconfig [] { cd ~/.config }
def --env public [] { cd ~/Documents/workspace/public }
def --env private [] { cd ~/Documents/workspace/private }
def --env learn [] { cd ~/Documents/workspace/learn }
def --wrapped --env cnvim [...rest] {
    let nvimConfigDir = ("~/.config/nvim" | path expand)
    if ($nvimConfigDir | path exists) {
        cd $nvimConfigDir
        ^nvim ...$rest
    } else {
        print $"Neovim config directory not found: ($nvimConfigDir)"
    }
}
def --env cdotfiles [] { cd ~/.dotfiles }
def --wrapped --env note [...rest] {
    let preferredNotesDir = ("~/Documents/notes/obsidian-notes" | path expand)
    let fallbackNotesDir = ("~/Documents/workspace/private/notes" | path expand)

    if ($preferredNotesDir | path exists) {
        cd $preferredNotesDir
        ^nvim ...$rest
    } else if ($fallbackNotesDir | path exists) {
        cd $fallbackNotesDir
        ^nvim ...$rest
    } else {
        print $"Notes directory not found. Checked: ($preferredNotesDir), ($fallbackNotesDir)"
    }
}

def killport [port?: int] {
    if $port == null {
        print "Usage: killport <port>"
        return
    }

    let pids = (
        ^lsof -t -i $"($port)"
        | lines
        | where {|pid| $pid != "" }
    )

    if ($pids | is-empty) {
        print $"No process found on port ($port)"
        return
    }

    $pids | each {|pid| ^sudo kill -9 $pid }
}

def --env venv [state?: string] {
    let mode = ($state | default "")
    if $mode == "on" {
        print "Use a Nushell-native venv script, e.g. source-env ./venv/bin/activate.nu"
        print "If your venv only has bash activate, run it from bash/zsh instead."
        return
    }

    if $mode == "off" {
        if ("VIRTUAL_ENV" in ($env | columns)) {
            hide-env VIRTUAL_ENV
        }
        print "If PATH was changed by activation, open a new shell to fully reset it."
        return
    }

    print "Usage: venv on|off"
}
