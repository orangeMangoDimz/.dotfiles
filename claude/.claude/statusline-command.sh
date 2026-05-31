#!/bin/sh
input=$(cat)
cwd=$(echo "$input" | jq -r '.cwd')
dir=$(basename "$cwd")
user=$(whoami)
host=$(hostname -s)
printf "\033[01;32m[%s@%s\033[01;37m %s\033[01;32m]\033[00m" "$user" "$host" "$dir"
