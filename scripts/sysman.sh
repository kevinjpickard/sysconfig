#!/bin/bash
# sysman - System Manual Viewer
# A flexible tool to read your system manual dynamically.

# Resolve absolute path to manual directory
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MANUAL_DIR="$(dirname "$DIR")/manual"

if [ ! -d "$MANUAL_DIR" ]; then
    echo "Manual directory not found: $MANUAL_DIR"
    exit 1
fi

MODE="${1:-interactive}"

case "$MODE" in
    glow)
        if command -v glow &>/dev/null; then
            glow "$MANUAL_DIR"
        else
            echo "glow is not installed. Use 'yay -S glow' to install."
            exit 1
        fi
        ;;
    fzf)
        if command -v fzf &>/dev/null && command -v bat &>/dev/null; then
            find "$MANUAL_DIR" -name "*.md" | fzf --preview="bat --color=always --style=plain {}" --bind "enter:execute(bat --pager=less {})"
        else
            echo "fzf or bat is missing. Install with 'yay -S fzf bat'."
            exit 1
        fi
        ;;
    interactive|*)
        if command -v glow &>/dev/null; then
            glow "$MANUAL_DIR"
        elif command -v fzf &>/dev/null && command -v bat &>/dev/null; then
            find "$MANUAL_DIR" -name "*.md" | fzf --preview="bat --color=always --style=plain {}" --bind "enter:execute(bat --pager=less {})"
        else
            echo "No interactive viewer found. Falling back to plain list:"
            ls -l "$MANUAL_DIR"
            echo -e "\nTip: Install 'glow' or 'fzf' + 'bat' for a better experience."
        fi
        ;;
esac
