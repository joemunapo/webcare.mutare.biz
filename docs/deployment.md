# Deployment

This repo supports three deployment styles.

## Server Pull Cron

Use this when the server should pull the repo itself, avoiding shared SSH deploy keys.

On the `manikauk` cPanel terminal:

```bash
mkdir -p /home/manikauk/repos
git clone https://github.com/joemunapo/webcare.mutare.biz.git /home/manikauk/repos/webcare.mutare.biz
cd /home/manikauk/repos/webcare.mutare.biz
WHMCS_ROOT=/home/manikauk/public_html DEPLOY_REPO=/home/manikauk/repos/webcare.mutare.biz ./scripts/server-pull-deploy.sh
```

Then add this cron entry:

```cron
*/10 * * * * WHMCS_ROOT=/home/manikauk/public_html DEPLOY_REPO=/home/manikauk/repos/webcare.mutare.biz /home/manikauk/repos/webcare.mutare.biz/scripts/server-pull-deploy.sh >/dev/null 2>&1
```

The cron command pulls `origin/main`, resets the server checkout to that revision, and deploys only:

- `templates/webcare`
- `templates/orderforms/webcare_cart`

Logs are written to `/home/manikauk/repos/webcare.mutare.biz/deploy.log`.

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
