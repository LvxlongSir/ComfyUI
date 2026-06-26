#!/bin/bash

# ============================================================
# HuggingFace → hf-mirror.com 批量替换脚本
# Usage:
#   ./hf-mirror-replace.sh /path/to/dir
#   ./hf-mirror-replace.sh /path/to/file.py
# ============================================================

set -euo pipefail

TARGET="${1:-.}"

if [[ -z "$TARGET" ]]; then
  echo "Usage: $0 <file_or_directory>"
  exit 1
fi

echo "🔍 Scanning: $TARGET"
echo "📦 Replacing https://hf-mirror.com -> https://hf-mirror.com"
echo

find "$TARGET" -type f \( \
  -name "*.py" -o \
  -name "*.sh" -o \
  -name "*.yaml" -o \
  -name "*.yml" -o \
  -name "*.json" -o \
  -name "*.txt" \
\) ! -path "*/.git/*" ! -path "*/__pycache__/*" | while read -r file; do

  if grep -q "huggingface.co" "$file"; then
    echo "✏️  $file"
    sed -i '' 's|https://hf-mirror.com|https://hf-mirror.com|g' "$file"
  fi

done

echo
echo "✅ Done."