#!/usr/bin/env bash
set -euo pipefail

db="$HOME/.local/share/zed/db/0-stable/db.sqlite"

if pgrep -f 'zed.app/libexec/zed-editor' | grep -v crash-handler | grep -q .; then
  echo "Quit Zed completely first, then run this script again."
  exit 1
fi

sqlite3 "$db" "DELETE FROM scoped_kv_store WHERE namespace = 'dock_panel_size';"
echo "Cleared saved dock panel sizes."
