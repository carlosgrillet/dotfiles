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

send_patches() {
    # send_patches - send a single patch or a patch series via git send-email
    #
    # Usage:
    #   send_patches --target <patch-file|patches-dir> [--to <addr>] [--dry-run]
    #
    # - File:   runs get_maintainer.pl on it, shows recipients, asks for
    #           confirmation, then sends it standalone.
    # - Folder: builds one recipient list (union of get_maintainer.pl over all
    #           0*.patch files), sends 0000-cover-letter.patch first, grabs its
    #           Message-Id, then sends the rest with --in-reply-to pointing at
    #           the cover letter so they thread correctly.
    #
    # --to       overrides recipients: send only to this address instead of
    #            the get_maintainer.pl results.
    # --dry-run passes --dry-run through to git send-email (no mail sent).

    setopt local_options pipefail

    TARGET=""
    DRY_RUN=0
    TO=""

    while [ $# -gt 0 ]; do
        case "$1" in
        --target)
            TARGET="$2"
            shift 2
            ;;
        --to)
            TO="$2"
            shift 2
            ;;
        --dry-run)
            DRY_RUN=1
            shift
            ;;
        *)
            echo "Usage: $0 --target <patch-file|patches-dir> [--dry-run]" >&2
            return 1
            ;;
        esac
    done

    if [ -z "$TARGET" ]; then
        echo "Usage: $0 --target <patch-file|patches-dir> [--dry-run]" >&2
        return 1
    fi

    REPO_ROOT=$(git rev-parse --show-toplevel) || return 1
    GET_MAINTAINER="$REPO_ROOT/scripts/get_maintainer.pl"
    SMTP_PASS=$(op read 'op://Private/Zoho/password') || return 1

    RECIP_FILE=$(mktemp)

    confirm() {
        local prompt="$1"
        read -r "ans?$prompt [y/N] "
        [[ "$ans" =~ ^[Yy]$ ]]
    }

    send_email() {
        local extra=()
        [ "$DRY_RUN" -eq 1 ] && extra+=(--dry-run)
        if [ -n "$TO" ]; then
            extra+=(--to="$TO")
        else
            extra+=(--to-cmd="cat $RECIP_FILE")
        fi
        git send-email \
            --smtp-pass="$SMTP_PASS" \
            --confirm=never \
            "${extra[@]}" \
            "$@"
    }

    {
    if [ -f "$TARGET" ]; then
        if [ -n "$TO" ]; then
            echo "Recipient for $TARGET: $TO"
        else
            "$GET_MAINTAINER" --nogit-fallback "$TARGET" | sort -u > "$RECIP_FILE"
            echo "Recipients for $TARGET:"
            cat "$RECIP_FILE"
        fi
        confirm "Send this patch?" || return 0

        send_email "$TARGET" || return 1

    elif [ -d "$TARGET" ]; then
        setopt local_options nullglob
        patches=("$TARGET"/0*.patch)

        if [ ${#patches[@]} -eq 0 ]; then
            echo "error: no 0*.patch files in $TARGET" >&2
            return 1
        fi

        if [ -n "$TO" ]; then
            echo "Recipient for series: $TO"
        else
            "$GET_MAINTAINER" --nogit-fallback "${patches[@]}" | sort -u > "$RECIP_FILE"
            echo "Recipients for series:"
            cat "$RECIP_FILE"
        fi
        confirm "Send series?" || return 0

        cover=("$TARGET"/0000-*.patch)
        if [ ${#cover[@]} -ne 1 ]; then
            echo "error: expected exactly one 0000-cover-letter patch in $TARGET" >&2
            return 1
        fi

        echo "Sending cover letter: ${cover[0]}"
        out=$(send_email "${cover[0]}") || return 1
        echo "$out"

        msgid=$(grep -m1 -ioP 'Message-ID:\s*<\K[^>]+' <<< "$out")
        if [ -z "$msgid" ]; then
            echo "error: could not find Message-Id of cover letter" >&2
            return 1
        fi
        echo "Cover letter Message-Id: $msgid"

        rest=()
        for f in "${patches[@]}"; do
            [[ $(basename "$f") == 0000-* ]] || rest+=("$f")
        done
        if [ ${#rest[@]} -gt 0 ]; then
            echo "Sending ${#rest[@]} patch(es), in-reply-to <$msgid>"
            send_email --in-reply-to="$msgid" "${rest[@]}" || return 1
        fi

    else
        echo "error: $TARGET is neither a file nor a directory" >&2
        return 1
    fi
    } always {
        rm -f "$RECIP_FILE"
    }
}
