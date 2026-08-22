#!/usr/bin/env bash
set -euo pipefail

VERSION="v0.9.6"
CONFIG_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)"
PATCH_FILE="$CONFIG_ROOT/patches/hyprlock-input-blur.patch"
BUILD_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/hyprlock-input-blur.XXXXXX")"
SOURCE_DIR="$BUILD_ROOT/hyprlock"
BUILD_DIR="$BUILD_ROOT/build"
TARGET_BIN="$HOME/.local/bin/hyprlock"

cleanup() {
    rm -rf -- "$BUILD_ROOT"
}
trap cleanup EXIT

git clone --depth 1 --branch "$VERSION" https://github.com/hyprwm/hyprlock.git "$SOURCE_DIR"
git -C "$SOURCE_DIR" apply --check "$PATCH_FILE"
git -C "$SOURCE_DIR" apply "$PATCH_FILE"

cmake -S "$SOURCE_DIR" -B "$BUILD_DIR" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="$BUILD_ROOT/install"
cmake --build "$BUILD_DIR" --parallel

install -Dm755 "$BUILD_DIR/hyprlock" "$TARGET_BIN"
"$TARGET_BIN" --version
