#!/usr/bin/env bash
set -Eeuo pipefail

# Argo-Pro small bootstrap installer.
# It downloads the whole GitHub repository archive, normalizes text files to Unix LF,
# validates argox.sh syntax, and then runs argox.sh.

REPO_OWNER="${REPO_OWNER:-hkzping999}"
REPO_NAME="${REPO_NAME:-Argo-Pro}"
BRANCH="${BRANCH:-main}"

ARCHIVE_URL="https://github.com/${REPO_OWNER}/${REPO_NAME}/archive/refs/heads/${BRANCH}.tar.gz"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

need_cmd() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "Missing required command: $1" >&2
    exit 1
  }
}

need_cmd bash
need_cmd tar

if command -v curl >/dev/null 2>&1; then
  download_cmd=(curl -fsSL)
elif command -v wget >/dev/null 2>&1; then
  download_cmd=(wget -qO-)
else
  echo "Missing curl or wget" >&2
  exit 1
fi

echo "Downloading ${REPO_OWNER}/${REPO_NAME}@${BRANCH} ..."
"${download_cmd[@]}" "$ARCHIVE_URL" > "$TMP_DIR/source.tar.gz"

tar -xzf "$TMP_DIR/source.tar.gz" -C "$TMP_DIR"
SRC_DIR="$(find "$TMP_DIR" -maxdepth 1 -type d -name "${REPO_NAME}-*" | head -n 1)"
if [ -z "${SRC_DIR:-}" ] || [ ! -d "$SRC_DIR" ]; then
  echo "Failed to locate extracted source directory" >&2
  exit 1
fi

cd "$SRC_DIR"

echo "Normalizing text files to Unix LF ..."
if command -v python3 >/dev/null 2>&1; then
  python3 - <<'PY'
from pathlib import Path
patterns = [
    "*.sh", "*.conf", "*.md", "*.txt", "*.json", "*.yml", "*.yaml",
    ".gitattributes", ".editorconfig",
    "modules/**/*.sh", "scripts/**/*.sh", "tests/**/*.sh", "docs/**/*.md",
]
files = []
for pat in patterns:
    files.extend(Path('.').glob(pat))
for p in sorted(set(files)):
    if not p.is_file():
        continue
    b = p.read_bytes()
    if b'\0' in b:
        continue
    fixed = b.replace(b'\r\n', b'\n').replace(b'\r', b'\n')
    if fixed != b:
        p.write_bytes(fixed)
PY
else
  find . -type f \( -name "*.sh" -o -name "*.conf" -o -name "*.md" -o -name "*.txt" -o -name "*.json" -o -name "*.yml" -o -name "*.yaml" \) \
    -exec sed -i 's/\r$//' {} \;
fi

if [ ! -f ./argox.sh ]; then
  echo "argox.sh not found in repository archive" >&2
  exit 1
fi

chmod +x ./argox.sh

echo "Checking argox.sh syntax ..."
bash -n ./argox.sh

echo "Starting Argo-Pro installer ..."
exec bash ./argox.sh "$@"
