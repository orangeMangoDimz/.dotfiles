#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
powerprofilesctl set balanced
sudo -n "$SCRIPT_DIR/SetEPP.sh"
