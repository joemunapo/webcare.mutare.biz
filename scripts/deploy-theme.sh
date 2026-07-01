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

echo "Deployed WebCare WHMCS theme to $WHMCS_ROOT"
