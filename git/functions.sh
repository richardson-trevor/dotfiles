#!/bin/bash

# Current branch or SHA if detached.
function git-current-branch-sha() {
    'git branch | perl -ne '"'"'/^\* (?:\(detached from (.*)\)|(.*))/ && print "$1$2"'"'"''
}

function git-clone-cd() {
    gh repo clone $1 && cd "$(basename $1 .git)"
}

alias gc='git-clone-cd'

# GitHub URL for current repo.
function github_url() {
    local user_repo
    local remotename="${@:-origin}"
    local remote
    remote="$(git remote -v | awk '/^'"$remotename"'.*\(push\)$/ {print $2}')"

    [[ "$remote" ]] || return

    user_repo="$(echo "$remote" | perl -pe 's/.*://;s/\.git$//')"
    echo "https://github.com/$user_repo"
}

# GitHub URL for current repo, including current branch + path.
alias github_url_branch='echo $(github_url)/tree/$(git-current-branch-sha)/$(git rev-parse --show-prefix)'

# git log with per-commit cmd-clickable GitHub URLs (iTerm)
function github_clickable_log() {
  git log "$@" --name-status --color | awk "$(cat <<AWK
    /^.*commit [0-9a-f]{40}/ {sha=substr(\$2,1,7)}
    /^[MA]\t/ {printf "%s\t$(github_url)/blob/%s/%s\n", \$1, sha, \$2; next}
    /.*/ {print \$0}
AWK
  )" | less -F
}

# open last commit in GitHub, in the browser.
function github_last_commit() {
    local n="${@:-1}"
    n=$((n-1))
    git web--browse  $(git log -n 1 --skip=$n --pretty=oneline | awk "{printf \"$(github_url)/commit/%s\", substr(\$1,1,7)}")
}

# open current branch + path in GitHub, in the browser.
alias github_web='git web--browse $(github_url_branch)'

. ~/.files/git/outstanding.sh
