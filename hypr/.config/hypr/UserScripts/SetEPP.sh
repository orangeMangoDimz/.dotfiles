#!/usr/bin/env bash
set -euo pipefail
for f in /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference; do
  printf '%s\n' performance >"$f"
done
