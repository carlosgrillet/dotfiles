tm() {
    if [ -z "$1" ]; then
        echo "Use this to attach to a tmux session"
        echo "Usage: tm <session-name>"
        return 1
    else
        tmux a -t "$1"
    fi
}

tk() {
    if [ -z "$1" ]; then
        echo "Use this to kill a specific tmux session"
        echo "Usage: tk <session-name>"
        return 1
    else
        tmux kill-session -t "$1"
    fi
}

showme() {
    if [ -z "$1" ]; then
        echo "Use this to find files within a directory"
        echo "Usage: showme <regex>"
        return 1
    else
        find . | grep -i "$1"
    fi
}

search() {
    if [ -z "$1" ]; then
        echo "Use this to find text within all files in a directory"
        echo "Usage: search <regex>"
        return 1
    else
        egrep -rniI "$1" . | sort | uniq
    fi
}

sshkey() {
    echo "#Carlos Grillet"
    cat ~/.ssh/id_rsa.pub
}

pubip() {
    if [ -x "$(command -v jq)" ]; then
        curl -s "ipinfo.io/" | jq
    else  
        curl -s "ipinfo.io/"
    fi
}

ktoto() {
    if [ -x "$(command -v jq)" ]; then
        curl -s "ipinfo.io/$1" | jq
    else  
        curl -s "ipinfo.io/$1"
    fi
}

analyze-repo() {
    if ! command -v git-of-theseus-analyze &> /dev/null; then
        echo "git-of-theseus not installed"
        read
    fi

    if ! [ -d ./.git ]; then
        echo "Not in root of the repo"
        exit 1
    fi

    mkdir .git-of-theseus
    cd .git-of-theseus || exit 1
    git-of-theseus-analyze --procs "$(nproc)" ../

    git-of-theseus-stack-plot cohorts.json --outfile code-over-years.png
    git-of-theseus-stack-plot cohorts.json --normalize --outfile code-over-years-normal.png

    git-of-theseus-line-plot authors.json --max-n 10 --outfile code-authors.png
    git-of-theseus-line-plot authors.json --normalize --max-n 10 --outfile code-authors-normal.png

    git-of-theseus-line-plot dirs.json --max-n 10 --outfile dirs.png
    git-of-theseus-line-plot dirs.json --normalize --max-n 10 --outfile dirs-normal.png

    git-of-theseus-line-plot domains.json --max-n 10 --outfile domains.png
    git-of-theseus-line-plot domains.json --normalize --max-n 10 --outfile domains-normal.png

    git-of-theseus-line-plot exts.json --max-n 10 --outfile file-extensions.png
    git-of-theseus-line-plot exts.json --normalize --max-n 10 --outfile file-extensions-normal.png

    git-of-theseus-survival-plot --exp-fit survival.json --outfile half-life-code.png
}
