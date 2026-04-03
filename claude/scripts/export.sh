#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_DIR="${HOME}/.claude"

echo "Exporting Claude config from: ${SOURCE_DIR}"
echo "Target: ${REPO_DIR}"
echo ""

# Agents
if [[ -d "${SOURCE_DIR}/agents" ]]; then
  rsync -a --delete --exclude '.git/' "${SOURCE_DIR}/agents/" "${REPO_DIR}/agents/"
  echo "  ✓ ${SOURCE_DIR}/agents/ → agents/"
else
  echo "  ⏭ No agents directory found, skipping"
fi

# Settings
if [[ -f "${SOURCE_DIR}/settings.json" ]]; then
  cp "${SOURCE_DIR}/settings.json" "${REPO_DIR}/settings/settings.json"
  echo "  ✓ ${SOURCE_DIR}/settings.json → settings/settings.json"
else
  echo "  ⏭ No settings.json found, skipping"
fi

# Global CLAUDE.md
if [[ -f "${SOURCE_DIR}/CLAUDE.md" ]]; then
  cp "${SOURCE_DIR}/CLAUDE.md" "${REPO_DIR}/claude-md/CLAUDE.md"
  echo "  ✓ ${SOURCE_DIR}/CLAUDE.md → claude-md/CLAUDE.md"
else
  echo "  ⏭ No CLAUDE.md found, skipping"
fi

echo ""
echo "Done. Review changes with: git diff"
