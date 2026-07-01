#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

if [ ! -d node_modules ]; then
  echo "node_modules not found. Run npm install first." >&2
  exit 1
fi

npm run build
