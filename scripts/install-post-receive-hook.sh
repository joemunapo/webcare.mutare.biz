#!/usr/bin/env bash
set -euo pipefail

: "${BARE_REPO:?Set BARE_REPO to the server-side bare Git repository path.}"
: "${DEPLOY_WORKTREE:?Set DEPLOY_WORKTREE to the checkout path used by the hook.}"
: "${WHMCS_ROOT:?Set WHMCS_ROOT to the WHMCS installation path.}"

mkdir -p "$DEPLOY_WORKTREE"

cat > "$BARE_REPO/hooks/post-receive" <<HOOK
#!/usr/bin/env bash
set -euo pipefail

while read -r oldrev newrev refname; do
  if [ "\$refname" = "refs/heads/main" ]; then
    GIT_DIR="$BARE_REPO" GIT_WORK_TREE="$DEPLOY_WORKTREE" git checkout -f main
    cd "$DEPLOY_WORKTREE"
    npm ci
    npm run build
    WHMCS_ROOT="$WHMCS_ROOT" ./scripts/deploy-theme.sh
  fi
done
HOOK

chmod +x "$BARE_REPO/hooks/post-receive"
echo "Installed post-receive hook at $BARE_REPO/hooks/post-receive"
