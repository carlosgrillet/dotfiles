create_tmux_session() {
    if ! command -v tmux >/dev/null 2>&1; then
        echo "please install tmux" >&2
        return 1
    fi

    # Parameters: session_name, base_path, window_configs
    local session_name="$1"
    local base_path="$2"
    shift 2
    local window_configs=("$@")

    # Check if the session already exists
    if tmux has-session -t "$session_name" 2>/dev/null; then
        return 0
    fi

    # Create a new detached session
    tmux new-session -d -s "$session_name" -n "REPO" -c "$base_path"

  # Loop through window configurations and create windows
    local index=1
    for config in "${window_configs[@]}"; do
        local window_name="${config%%:*}"
        local command="${config#*:}"

        tmux new-window -t "$session_name" -n "$window_name" -c "$base_path"
        tmux send-keys -t "$session_name:$((index + 1))" "$command" C-m
        ((index++))
    done

    tmux select-window -t "$session_name:1"
}

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


### Tmux sessions

# session_name() {
#   create_tmux_session "session_name" "session_root_dir" \
#     "window_name:window_command" \
# }
# session_name

kerneldev() {
    local root="${KERNEL_ROOT:-/repos/kernel}"
    local tree="$1"

    if [[ -z "$tree" ]]; then
        echo "Start a kernel development session in tmux" >&2
        echo "Usage: kerneldev <tree>" >&2
        echo "Available trees in ${root}:" >&2
        for d in "$root"/*(N/); do echo "  ${d:t}" >&2; done
        return 1
    fi

    if [[ "$tree" == */* || "$tree" == "." || "$tree" == ".." ]]; then
        echo "kerneldev: '${tree}' must be a single directory name" >&2
        return 1
    fi

    local path="${root}/${tree}"

    if [[ ! -d "$path" ]]; then
        echo "kerneldev: no tree named '${tree}' in ${root}" >&2
        return 1
    fi

    local session="linux-${tree}"

    create_tmux_session "$session" "$path" \
        "CODE:nvim" \
        "GIT:lazygit" \
        "LENS:claude" || return 1

    if [[ -n "$TMUX" ]]; then
        tmux switch-client -t "=${session}"
    else
        tmux attach-session -t "=${session}"
    fi
}

