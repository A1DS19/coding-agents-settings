#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET_DIR="${HOME}/.claude"

echo "Installing Claude config from: ${REPO_DIR}"
echo "Target: ${TARGET_DIR}"
echo ""

# Agents
mkdir -p "${TARGET_DIR}/agents"
rsync -a --delete --exclude '.git/' "${REPO_DIR}/agents/" "${TARGET_DIR}/agents/"
echo "  ✓ agents/ → ${TARGET_DIR}/agents/"

# Settings
cp "${REPO_DIR}/settings/settings.json" "${TARGET_DIR}/settings.json"
echo "  ✓ settings/settings.json → ${TARGET_DIR}/settings.json"

# Global CLAUDE.md
cp "${REPO_DIR}/claude-md/CLAUDE.md" "${TARGET_DIR}/CLAUDE.md"
echo "  ✓ claude-md/CLAUDE.md → ${TARGET_DIR}/CLAUDE.md"

echo ""
echo "Done. Installed:"
echo "  - $(find "${TARGET_DIR}/agents" -name '*.md' -not -name 'README.md' | wc -l | tr -d ' ') agents"
echo "  - settings.json"
echo "  - CLAUDE.md"
