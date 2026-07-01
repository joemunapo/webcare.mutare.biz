#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

: "${WHMCS_ROOT:?Set WHMCS_ROOT to the WHMCS installation path.}"

if [ ! -d "$WHMCS_ROOT/templates" ]; then
  echo "WHMCS_ROOT does not look like a WHMCS install: $WHMCS_ROOT" >&2
  exit 1
fi

rsync -a --delete whmcs/templates/webcare/ "$WHMCS_ROOT/templates/webcare/"
rsync -a --delete whmcs/templates/orderforms/webcare_cart/ "$WHMCS_ROOT/templates/orderforms/webcare_cart/"

if [ -d whmcs/includes/hooks ]; then
  mkdir -p "$WHMCS_ROOT/includes/hooks"
  rsync -a whmcs/includes/hooks/ "$WHMCS_ROOT/includes/hooks/"
fi

echo "Deployed WebCare WHMCS theme to $WHMCS_ROOT"
