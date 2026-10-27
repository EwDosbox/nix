#!/usr/bin/env fish

# Script to bootstrap a Nix dev project with direnv auto-loading

set TEMPLATE_PATH "$HOME/1_project/nix/templates/template-flake.nix"

cp "$TEMPLATE_PATH" ./flake.nix

echo "use flake" > .envrc

direnv allow