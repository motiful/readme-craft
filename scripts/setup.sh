#!/usr/bin/env bash
set -euo pipefail

echo "readme-craft: checking dependencies..."
echo

# Node.js 18+
if ! command -v node &>/dev/null; then
  echo "  node: NOT FOUND — Node.js 18+ is required for logo generation"
  echo
  echo "Install Node.js: https://nodejs.org/"
  exit 1
fi

NODE_VERSION=$(node -e "console.log(process.versions.node.split('.')[0])")
if [ "$NODE_VERSION" -lt 18 ]; then
  echo "  node: v$(node --version) — requires 18+, please upgrade"
  exit 1
fi
echo "  node: $(command -v node) (v$(node --version | tr -d 'v'))"

# npm
if ! command -v npm &>/dev/null; then
  echo "  npm: NOT FOUND"
  exit 1
fi
echo "  npm: $(command -v npm)"

# Install npm dependencies if missing
SKILL_DIR="$(cd "$(dirname "$0")/.." && pwd)"
if [ ! -d "$SKILL_DIR/node_modules" ]; then
  echo
  echo "  Installing npm dependencies..."
  (cd "$SKILL_DIR" && npm install --silent)
fi
echo "  node_modules: installed"

echo
echo "All dependencies ready."
