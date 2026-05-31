#!/usr/bin/env bash
# ===========================================================================
# Claude Code Status Line — Catppuccin Mocha Theme
# Uses 24-bit true color ANSI escapes for exact palette matching.
# ===========================================================================
input=$(cat)

# ---------------------------------------------------------------------------
# Catppuccin Mocha palette (RGB)
# ---------------------------------------------------------------------------
CAT_GREEN="166;227;161"
CAT_TEAL="148;226;213"
CAT_SKY="137;220;235"
CAT_SAPPHIRE="116;199;236"
CAT_BLUE="137;180;250"
CAT_LAVENDER="180;190;254"
CAT_MAUVE="203;166;247"
CAT_PINK="245;194;231"
CAT_FLAMINGO="242;205;205"
CAT_PEACH="250;179;135"
CAT_MAROON="235;160;172"
CAT_RED="243;139;168"
CAT_YELLOW="249;226;175"
CAT_ROSEWATER="245;224;220"
CAT_TEXT="205;214;244"
CAT_SUBTEXT1="186;194;222"
CAT_SUBTEXT0="166;173;200"
CAT_OVERLAY0="108;112;134"
CAT_SURFACE1="69;71;90"
CAT_SURFACE0="49;50;68"

# True-color foreground helper
fg() { printf "\033[38;2;%sm" "$1"; }
bold_fg() { printf "\033[1;38;2;%sm" "$1"; }
reset="\033[0m"

# ---------------------------------------------------------------------------
# Progress bar gradient: 12 blocks from green → red across the palette
# ---------------------------------------------------------------------------
bar_palette=(
  "$CAT_GREEN"     "$CAT_TEAL"      "$CAT_SKY"
  "$CAT_SAPPHIRE"  "$CAT_BLUE"      "$CAT_LAVENDER"
  "$CAT_MAUVE"     "$CAT_PINK"      "$CAT_FLAMINGO"
  "$CAT_PEACH"     "$CAT_MAROON"    "$CAT_RED"
)

# ---------------------------------------------------------------------------
# Spinner (braille dots, Overlay0 colour)
# ---------------------------------------------------------------------------
spinner_frames=("\u2809" "\u2819" "\u2839" "\u2838" "\u283c" "\u2834" "\u2826" "\u2827" "\u2807" "\u280f")
current_usage_raw=$(echo "$input" | jq -r '.context_window.current_usage // empty' 2>/dev/null)
if [ -z "$current_usage_raw" ]; then
  sec=$(date +%S | sed 's/^0*//')
  sec=${sec:-0}
  frame_idx=$((sec % 10))
  spinner=" $(fg "$CAT_OVERLAY0")${spinner_frames[$frame_idx]}${reset}"
else
  spinner=""
fi

# ---------------------------------------------------------------------------
# Context window
# ---------------------------------------------------------------------------
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty' 2>/dev/null)
remaining_pct=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty' 2>/dev/null)

if [ -n "$used_pct" ] && [ -n "$remaining_pct" ]; then
  pct=$(printf '%.0f' "$used_pct")

  # Progress bar: 12 blocks, individually coloured
  filled=$((pct * 12 / 100))
  bar=""
  for i in $(seq 1 12); do
    idx=$((i - 1))
    if [ "$i" -le "$filled" ]; then
      c="${bar_palette[$idx]}"
      # Bold in the critical zone (>= 90%)
      if [ "$i" -ge 11 ]; then
        bar="${bar}$(bold_fg "$c")█${reset}"
      else
        bar="${bar}$(fg "$c")█${reset}"
      fi
    else
      bar="${bar}$(fg "$CAT_SURFACE1")░${reset}"
    fi
  done

  # Percentage label colour
  if [ "$pct" -ge 90 ]; then     pct_color="$(bold_fg "$CAT_RED")"
  elif [ "$pct" -ge 70 ]; then   pct_color="$(fg "$CAT_PEACH")"
  elif [ "$pct" -ge 40 ]; then   pct_color="$(fg "$CAT_YELLOW")"
  else                            pct_color="$(fg "$CAT_GREEN")"
  fi

  ctx_part="${bar} ${pct_color}${pct}%${reset}"
else
  ctx_part="$(fg "$CAT_OVERLAY0")waiting for context data${reset}"
fi

# ---------------------------------------------------------------------------
# Git branch + status indicators (Catppuccin styled)
# ---------------------------------------------------------------------------
git_part=""
if git -c core.hooksPath=/dev/null rev-parse --git-dir >/dev/null 2>&1; then
  branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)

  staged=$(git diff --cached --name-only 2>/dev/null | wc -l | tr -d ' ')
  unstaged=$(git diff --name-only 2>/dev/null | wc -l | tr -d ' ')
  untracked=$(git ls-files --others --exclude-standard 2>/dev/null | wc -l | tr -d ' ')

  indicators=""
  if [ "$staged" -gt 0 ]; then
    indicators="${indicators}$(fg "$CAT_GREEN") ${staged}${reset}"
  fi
  if [ "$unstaged" -gt 0 ]; then
    indicators="${indicators}$(fg "$CAT_PEACH") ${unstaged}${reset}"
  fi
  if [ "$untracked" -gt 0 ]; then
    indicators="${indicators}$(fg "$CAT_MAUVE") ${untracked}${reset}"
  fi

  if [ -z "$indicators" ]; then
    indicators="$(fg "$CAT_GREEN")${reset}"
  fi

  # Worktree detection: linked worktrees have .git/worktrees/<name> as gitdir
  worktree_part=""
  gitdir=$(git rev-parse --git-dir 2>/dev/null)
  if [[ "$gitdir" == *"/worktrees/"* ]]; then
    wt_name=$(basename "$gitdir")
    worktree_part=" $(fg "$CAT_SKY")⑂ ${wt_name}${reset}"
  fi

  git_part=" $(fg "$CAT_TEAL")${reset} $(fg "$CAT_BLUE")${branch}${reset}${indicators}${worktree_part}"
fi

# ---------------------------------------------------------------------------
# Model
# ---------------------------------------------------------------------------
model_name=$(echo "$input" | jq -r '.model.display_name // empty' 2>/dev/null)
model_part=""
if [ -n "$model_name" ]; then
  model_part="$(fg "$CAT_MAUVE")󰚩 ${model_name}${reset} "
fi

# ---------------------------------------------------------------------------
# Cost
# ---------------------------------------------------------------------------
cost=$(echo "$input" | jq -r '(.cost // empty) | if type == "object" then .total_cost_usd else . end // empty' 2>/dev/null)
cost_part=""
if [ -n "$cost" ] && [ "$cost" != "null" ]; then
  cost_fmt=$(printf '%.2f' "$cost" 2>/dev/null || echo "$cost")
  cost_part=" $(fg "$CAT_SUBTEXT0")\$${cost_fmt}${reset}"
fi

# ---------------------------------------------------------------------------
# Output
# ---------------------------------------------------------------------------
echo -e "${model_part}${ctx_part}${spinner}${git_part}${cost_part}"
