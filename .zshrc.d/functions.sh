vman() {
    man "$@" | col -b | nvim - +"set ft=man cc=78 nomod noma nu" -R
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

count_lines() {
    if [ "$#" -ne 2 ]; then
        echo "Usage: $0 <format> <folder>" >&2
        return 1
    fi

    local format=$1
    local folder=$2
    local awkscript="{ total+=\$1 } END { print total+0 }"

    if command -v fd &>/dev/null; then
        fd -t f -e "${format}" --full-path "${folder}" --exec wc -l | awk "${awkscript}"
        return
    fi

    find "${folder}" -type f -name "*.${format}" -exec wc -l {} + | awk "${awkscript}"
}
