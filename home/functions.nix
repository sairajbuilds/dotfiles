{ ... }:

{
  programs.zsh.initContent = ''
    proj() {
      if [ "$#" -ne 1 ]; then
        echo "Usage: proj <category/project>"
        return 1
      fi

      local project="$1"
      local project_dir="$HOME/Development/$project"
      local session="$(basename "$project_dir")"

      if [ ! -d "$project_dir" ]; then
        echo "📁 Creating $project_dir"

        mkdir -p "$project_dir" || return 1

        (
          cd "$project_dir" || exit

          git init

          cat > README.md <<EOF
# $session

## Description

TODO

## Getting Started

TODO
EOF
        )
      fi

      if tmux has-session -t "$session" 2>/dev/null; then
        if [ -n "$TMUX" ]; then
          tmux switch-client -t "$session"
        else
          tmux attach -t "$session"
        fi
        return
      fi

      tmux new-session -d -s "$session" -c "$project_dir"

      tmux rename-window -t "$session":1 shell

      tmux new-window -t "$session" -n editor -c "$project_dir"
      tmux send-keys -t "$session":editor "nvim ." C-m

      tmux new-window -t "$session" -n build -c "$project_dir"

      tmux new-window -t "$session" -n git -c "$project_dir"
      tmux send-keys -t "$session":git "lazygit" C-m

      tmux new-window -t "$session" -n codex -c "$project_dir"

      tmux select-window -t "$session":editor

      if [ -n "$TMUX" ]; then
        tmux switch-client -t "$session"
      else
        tmux attach -t "$session"
      fi
    }
  '';
}
