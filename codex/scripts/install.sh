#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET_DIR="${HOME}/.codex"

echo "Installing Codex config from: ${REPO_DIR}"
echo "Target: ${TARGET_DIR}"
echo ""

# Skills
if [[ -d "${REPO_DIR}/skills" ]]; then
  mkdir -p "${TARGET_DIR}/skills"
  rsync -a --delete --exclude '.git/' --exclude '.system/' "${REPO_DIR}/skills/" "${TARGET_DIR}/skills/"
  count=$(find "${TARGET_DIR}/skills" -type f | wc -l | tr -d ' ')
  echo "  ✓ skills/ → ${TARGET_DIR}/skills/ (${count} files)"
else
  echo "  ⏭ No skills directory found, skipping"
fi

echo ""
echo "Done."
