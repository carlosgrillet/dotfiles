get_to() {
    local opts=(--nogit-fallback --norolestats --pattern-depth=1)

    if [[ $(basename "$1") =~ 0000- ]]; then
        local dir patch patches=()
        dir=$(dirname "$1")
        for patch in "$dir"/*.patch; do
            [[ $(basename "$patch") =~ 0000- ]] && continue
            patches+=("$patch")
        done
        ./scripts/get_maintainer.pl --nol "${opts[@]}" "${patches[@]}"
    else
        local maint
        maint=$(./scripts/get_maintainer.pl --nol "${opts[@]}" "$1")
        if [[ -z "$maint" ]]; then
            echo "linux-kernel@vger.kernel.org"
        else
            echo "$maint"
        fi
    fi
}

get_cc() {
    local opts=(--nogit-fallback --norolestats --nor)

    if [[ $(basename "$1") =~ 0000- ]]; then
        local dir patch patches=()
        dir=$(dirname "$1")
        for patch in "$dir"/*.patch; do
            [[ $(basename "$patch") =~ 0000- ]] && continue
            patches+=("$patch")
        done
        ./scripts/get_maintainer.pl --nom "${opts[@]}" "${patches[@]}"
    else
        ./scripts/get_maintainer.pl --nom "${opts[@]}" "$1"
    fi
}
