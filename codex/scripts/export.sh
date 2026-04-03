#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="${HOME}/.codex/skills"
TARGET_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/skills"
MANIFEST_FILE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/skills.manifest.txt"

if [[ ! -d "${SOURCE_DIR}" ]]; then
  echo "Source directory not found: ${SOURCE_DIR}" >&2
  exit 1
fi

mkdir -p "${TARGET_DIR}"

rsync -a --delete --exclude '.git/' --exclude '.system/' "${SOURCE_DIR}/" "${TARGET_DIR}/"

{
  echo "# Codex skills manifest"
  echo "# Generated: $(date -u +"%Y-%m-%dT%H:%M:%SZ")"
  echo "# Source: ${SOURCE_DIR}"
  echo ""
  (cd "${TARGET_DIR}" && find . -type f | sort)
} > "${MANIFEST_FILE}"

echo "Synced skills to: ${TARGET_DIR}"
echo "Updated manifest: ${MANIFEST_FILE}"
