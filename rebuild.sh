#!/usr/bin/env bash
set -euo pipefail

exec sudo -H /run/current-system/sw/bin/darwin-rebuild switch \
  --flake "$HOME/.dotfiles#mac"