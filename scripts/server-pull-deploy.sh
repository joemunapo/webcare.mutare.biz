#!/usr/bin/env bash
set -euo pipefail

: "${DEPLOY_REPO:?Set DEPLOY_REPO to the server checkout path.}"
: "${WHMCS_ROOT:?Set WHMCS_ROOT to the WHMCS installation path.}"

BRANCH="${DEPLOY_BRANCH:-main}"
REMOTE="${DEPLOY_REMOTE:-origin}"
LOCK_FILE="${DEPLOY_LOCK_FILE:-$DEPLOY_REPO/.deploy.lock}"
LOG_FILE="${DEPLOY_LOG_FILE:-$DEPLOY_REPO/deploy.log}"

mkdir -p "$(dirname "$LOG_FILE")"

(
    flock -n 9 || {
        echo "$(date -Is) deploy already running" >> "$LOG_FILE"
        exit 0
    }

    cd "$DEPLOY_REPO"

    echo "$(date -Is) deploy start" >> "$LOG_FILE"
    git fetch --prune "$REMOTE" "$BRANCH" >> "$LOG_FILE" 2>&1
    git checkout "$BRANCH" >> "$LOG_FILE" 2>&1
    git reset --hard "$REMOTE/$BRANCH" >> "$LOG_FILE" 2>&1

    WHMCS_ROOT="$WHMCS_ROOT" ./scripts/deploy-theme.sh >> "$LOG_FILE" 2>&1
    echo "$(date -Is) deployed $(git rev-parse --short HEAD)" >> "$LOG_FILE"
) 9>"$LOCK_FILE"
