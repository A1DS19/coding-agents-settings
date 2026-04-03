#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Codex config bootstrap"
echo "Repo codex dir: ${ROOT_DIR}"
echo ""
echo "Suggested next steps:"
echo "1) Sync skills: ${ROOT_DIR}/scripts/sync_skills.sh"
echo "2) Review SYSTEM.md and WORKFLOWS.md"
echo "3) Add project-specific overrides in templates/"
