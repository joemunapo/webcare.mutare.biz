# WebCare WHMCS Theme

Deployment-ready WHMCS v9 child theme and order-form styling for WebCare by Mutare.biz.

## What This Repo Contains

- `whmcs/templates/webcare/` - WHMCS system child theme.
- `whmcs/templates/orderforms/webcare_cart/` - WHMCS order-form child template.
- `src/webcare.css` - Tailwind v4 source CSS.
- `scripts/build-theme.sh` - builds `css/custom.css`.
- `scripts/deploy-theme.sh` - copies the theme folders into a WHMCS install.
- `scripts/server-pull-deploy.sh` - server-side pull and deploy script for cron.

The system theme is a child of `twenty-one`, which keeps WHMCS core templates updateable and only overrides styling through `css/custom.css`.
The Tailwind build intentionally omits Preflight resets so the WHMCS parent theme keeps its expected base behavior.

## Local Build

```bash
npm install
npm run build
```

Open `preview/store.html` to see the visual direction without changing WHMCS settings.

## Deploy Manually

```bash
WHMCS_ROOT=/path/to/whmcs ./scripts/deploy-theme.sh
```

## Activate In WHMCS

1. Deploy the theme folders.
2. In WHMCS Admin, go to `Configuration > System Settings > General Settings`.
3. Select `WebCare by Mutare.biz` as the System Theme.
4. In `Configuration > System Settings > Products/Services`, set the Webcare product group order form template to `WebCare Cart` when ready.

Preview before switching live:

```text
https://webcare.mutare.biz/index.php/store/webcare-by-mutarebiz?systpl=webcare&carttpl=webcare_cart
```

## Server Pull Deploy

The production server pulls this repo and deploys only these folders:

- `whmcs/templates/webcare/`
- `whmcs/templates/orderforms/webcare_cart/`

The deployment deliberately avoids deleting or modifying WHMCS core files.
