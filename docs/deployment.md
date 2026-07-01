# Deployment

This repo uses server-side pull deployment.

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

## Production Safety

- Do not deploy into WHMCS core template folders like `twenty-one` or `standard_cart`.
- Preview first using `?systpl=webcare&carttpl=webcare_cart`.
- Keep `Legacy Webcare` hidden.
- Do not test by placing real orders or generating invoices.
