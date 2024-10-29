if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=( 
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    # zsh-bat
)

source $ZSH/oh-my-zsh.sh

# Alias general
alias cls="clear"
alias ls="colorls -a"
alias public='cd ~/Documents/workspace/public;ls'
alias private='cd ~/Documents/workspace/private;ls'
alias fzf="fzf --preview='cat {}'"
alias mango="sgpt"
alias disk_space="df -h /"
alias pgcli="PAGER='less -S' pgcli"
alias mycli="mycli --socket /var/run/mysqld/mysqld.sock -u root -p root"
alias desktop_app=" cd /usr/share/applications; ls"
alias cava="TERM=st-256color cava"
alias killport="f_killport"

# Alias path
alias test="cd /home/dimz/Documents/workspace/dummy; nvim;"
alias dklt="public; cd work; env on; cd diklatkerja; nvim;"
alias sk-fe="cd /home/dimz/Documents/workspace/public/skripsi/satu-farmasi-frontend; nvim;"
alias sk-be="/home/dimz/Documents/workspace/public/skripsi/satu-farmasi-backend; nvim;"
alias learn="/home/dimz/Documents/workspace/learn; nvim;"
alias spt="cd ~/.spotify_player/; ./spotify_player"
alias last_save="/home/dimz/.local/share/tmux/resurrect" # execute: ln -sf <file_name> last

# Alias django
alias dj_run="py38 manage.py runserver"
alias dj_make_db="py38 manage.py makemigrations"
alias dj_migrate="py38 manage.py migrate"
alias dj_seed="py38 seed.py run"
alias dj_db_seed="dj_make_db; dj_migrate; dj_seed;"

# Alias git
alias gst="git status"
alias gco="git checkout"
alias gco="git checkout"
alias gci="git commit"
alias gbr="git branch"

# Pushing and pulling
alias gp="git push"
alias gpo="git push origin"
alias gpf="git push --force-with-lease"
alias gpl="git pull"
alias gplo="git pull origin"

# Stashing
alias gsa="git stash apply"
alias gsc="git stash clear"
alias gsd="git stash drop"
alias gsl="git stash list"
alias gsp="git stash pop"
alias gss="git stash save"

# logging
alias glg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# Other useful shortcuts
alias gaa="git add --all"
alias gcm="git commit -m"
alias gcam="git commit -am"
alias gamend="git commit --amend"
alias gundo="git reset HEAD~1 --mixed"

# Branch management
alias gbd="git branch -d"
alias gbD="git branch -D"

# Merge and rebase
alias gm="git merge"
alias grb="git rebase"

# Diff
alias gd="git diff"
alias gds="git diff --staged"

# Remote management
alias gra="git remote add"
alias grr="git remote remove"
alias grv="git remote -v"

# Miscellaneous
alias gcp="git cherry-pick"
alias galias="git config --get-regexp ^alias\\."

# NPM
alias nrd="npm run dev"
alias nrb="npm run build"

# docker
alias dc="docker container"
alias di="docker image"
alias dv="docker volume"
alias dn="docker network"

# Kill port
f_killport() {
    if [ -z "$1" ]; then
        echo "Usage: killport <port>"
        return 1
    fi
    sudo kill -9 $(sudo lsof -t -i:$1)
}

# Alias ENV
env() {
        if [ "$1" = "on" ]; then
                source .env/bin/activate
        elif [ "$1" = "off" ]; then
                deactivate
        fi
}

# Alias python
alias py38="python3.8"
alias py311="python3.11"

# Enable fzf history search
bindkey '^R' fzf-history-widget

fzf-history-widget() {
    local selected_command
    selected_command=$(fc -l -n 1 | fzf --height 40% --reverse --tac --query="$LBUFFER") || return
    LBUFFER="$selected_command"
    zle accept-line
}

zle -N fzf-history-widget

# Color ls
source $(dirname $(gem which colorls))/tab_complete.sh

export PATH="$HOME/.config/composer/vendor/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Source catpuccin syntax highlight
source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh

export PATH="$HOME/.nvim/usr/bin:$PATH"

# NOTE: Bottom line
# feh <picture name>            -> open picture
# wdg-open                      -> open video

# bun completions
[ -s "/home/dimz/.bun/_bun" ] && source "/home/dimz/.bun/_bun"

# Export editor nvim
export EDITOR=nvim

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
