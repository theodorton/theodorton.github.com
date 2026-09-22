#!/usr/bin/env bash
set -euo pipefail
nix build --no-link 2>&1
