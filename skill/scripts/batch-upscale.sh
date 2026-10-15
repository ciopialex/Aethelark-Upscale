#!/usr/bin/env bash
# Aethelark batch upscale wrapper
# Usage: batch-upscale.sh <folder> [extra-flags...]
# Defaults to organic mode out of the box
set -euo pipefail

TARGET="${1:?Usage: batch-upscale.sh <folder> [flags...]}"
shift
exec aethelark-upscale "$TARGET" "$@"
