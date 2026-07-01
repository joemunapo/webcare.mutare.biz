# Deployment

This repo supports two deployment styles.

## GitHub Actions

Use this when GitHub is the shared source of truth.

1. Push this repo to GitHub.
2. Add these repository secrets:
   - `WHMCS_SSH_HOST`
   - `WHMCS_SSH_USER`
   - `WHMCS_SSH_PORT`
   - `WHMCS_SSH_KEY`
   - `WHMCS_ROOT`
3. Push to `main`.

The workflow builds Tailwind CSS and deploys only:

- `templates/webcare`
- `templates/orderforms/webcare_cart`

## Server-Side Git Hook

Use this when the server hosts a bare Git repo and a push should deploy directly.

```bash
BARE_REPO=/home/deploy/webcare-theme.git \
DEPLOY_WORKTREE=/home/deploy/webcare-theme-worktree \
WHMCS_ROOT=/home/webcare/public_html \
./scripts/install-post-receive-hook.sh
```

After this, pushing to the bare repo's `main` branch will:

1. Check out the repo to `DEPLOY_WORKTREE`.
2. Run `npm ci`.
3. Build Tailwind CSS.
4. Deploy only the theme folders into WHMCS.

## Production Safety

- Do not deploy into WHMCS core template folders like `twenty-one` or `standard_cart`.
- Preview first using `?systpl=webcare&carttpl=webcare_cart`.
- Keep `Legacy Webcare` hidden.
- Do not test by placing real orders or generating invoices.
