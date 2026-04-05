# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# bashrc.d
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# Java
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
export PATH=$JAVA_HOME/bin:$PATH

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Conda
__conda_setup="$('/home/sairaj/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/sairaj/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/sairaj/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/sairaj/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

# Rust
. "$HOME/.cargo/env"

# Foundry
export PATH="$PATH:$HOME/.foundry/bin"

# Flutter & Android
export PATH="$HOME/Development/flutter/bin:$PATH"
export PATH="$PATH:$HOME/.pub-cache/bin"
export ANDROID_HOME="$HOME/Android/sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"

# rbenv (remove these two lines if you don't use Ruby)
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Gradle
export PATH=$PATH:/opt/gradle/gradle-8.7/bin

# --------------------------------------------------
# Project session launcher for tmux
# --------------------------------------------------

proj() {
  if [ -z "$1" ]; then
    echo "Usage: proj <project-name>"
    return
  fi

  PROJECT_NAME="$1"
  PROJECT_DIR="$HOME/Development/Web3/Projects/$PROJECT_NAME"
  SESSION_NAME="$PROJECT_NAME"

  if [ ! -d "$PROJECT_DIR" ]; then
    echo "Project not found:"
    echo "$PROJECT_DIR"
    return
  fi

  # If session exists → attach
  if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    if [ -n "$TMUX" ]; then
      tmux switch-client -t "$SESSION_NAME"
    else
      tmux attach -t "$SESSION_NAME"
    fi
    return
  fi

  # Otherwise create new session
  tmux new-session -d -s "$SESSION_NAME" -c "$PROJECT_DIR"

  tmux rename-window -t "$SESSION_NAME":1 "shell"

  tmux new-window -t "$SESSION_NAME":2 -n "editor" -c "$PROJECT_DIR"
  tmux send-keys -t "$SESSION_NAME":2 "nvim ." C-m

  tmux new-window -t "$SESSION_NAME":3 -n "build" -c "$PROJECT_DIR"

  tmux new-window -t "$SESSION_NAME":4 -n "git" -c "$PROJECT_DIR"
  tmux send-keys -t "$SESSION_NAME":4 "lazygit" C-m

  tmux select-window -t "$SESSION_NAME":2

  tmux attach -t "$SESSION_NAME"
}

#Update
update() {
  echo "Updating system..."
  sudo dnf upgrade -y
  echo "Done."
}

#Browser
zenb() {
  zen &
}



# Aliases
alias mongo-start="docker run --name mongodb -d -p 27017:27017 mongo:latest"
alias mongo-stop="docker stop mongodb && docker rm mongodb"
alias mongo-shell="docker exec -it mongodb mongosh"
alias python=python3
alias fixdns='sudo systemctl restart systemd-resolved'
alias fixbluetooth='sudo systemctl restart bluetooth && sleep 2 && bluetoothctl power on'
bash ~/playground/roast.sh
eval "$(starship init bash)"
alias ping9='ping 9.9.9.9'
alias zen='flatpak run app.zen_browser.zen'
export PATH=$PATH:/var/lib/flatpak/exports/bin:$HOME/.local/share/flatpak/exports/bin
alias work="tmux attach -t main || tmux new -s main -c ~/Development"
alias web3="cd ~/Development/Web3/Projects"
alias dev="cd ~/Development"
alias work="tmux attach -t main || tmux new -s main -c ~/Development/"
alias dev="tmux attach -t main || tmux new -s main -c ~/Development/"
alias web3="tmux attach -t main || tmux new -s main -c ~/Development/Web3/Projects"
eval "$(zoxide init bash)"
alias dev="cd ~/Development"
alias web3="cd ~/Development/Web3/Projects"
alias backend="cd ~/Development/Backend/Projects"
alias exp="cd ~/Development/Experiments"
alias tools="cd ~/Development/Tools"
# bat
alias cat="bat"

# eza
alias ls="eza --icons"
alias ll="eza --icons -la"
alias lt="eza --icons --tree --level=2"

# fzf
eval "$(fzf --bash)"
