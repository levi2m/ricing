#!/usr/bin/env bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# 1) create config dirs
mkdir -p "$HOME/.komorebi" "$HOME/.yasb"

# 2) copy your custom files
cp "$REPO_DIR/komorebi/"* "$HOME/.komorebi/"
cp "$REPO_DIR/yasb/"*     "$HOME/.yasb/"

# 3) install YASB dependencies
pip install --user -r "$REPO_DIR/yasb/requirements.txt"

echo "✅ Configs copied. To launch:"
echo "   komorebic start & python -m yasb --config \$HOME/.yasb/config.yaml --styles \$HOME/.yasb/styles.css"
