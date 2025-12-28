create_tmux_session() {
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

### Tmux sessions

tmoperator() {
  create_tmux_session "operator" \
    "$HOME/github/nso-operator" \
    "CODE:nvim" \
}
tmoperator
