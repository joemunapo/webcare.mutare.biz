# WHMCS v9 Child Theme Notes

Research checked against WHMCS Developer Documentation on 2026-07-01.

## System Theme

WHMCS recommends child themes for customisations. A child theme inherits templates and assets from a parent theme, and the child only needs to contain files that are customised. CSS-only changes can live in `css/custom.css`, which default WHMCS themes load automatically after the parent theme CSS.

This repo uses the WHMCS v9 `nexus` system theme as the parent. Keep customisations in the `webcare` child theme so WHMCS core templates remain updateable.

Minimum system child theme:

```yaml
name: "WebCare by Mutare.biz"
author: "Mutare.biz"
config:
  parent: nexus
```

Preview with:

```text
?systpl=webcare
```

Activate from:

```text
Configuration > System Settings > General Settings > System Theme
```

## Order Form Template

Order form templates are separate from system themes and control product/cart pages. WHMCS supports parent-child order form templates too. The custom template only needs a `theme.yaml` and the files being overridden.

Minimum order-form child:

```yaml
name: "WebCare Cart"
author: "Mutare.biz"
config:
  parent: standard_cart
```

Preview with:

```text
?carttpl=webcare_cart
```

Activate per product group from:

```text
Configuration > System Settings > Products/Services
```

## References

- https://developers.whmcs.com/themes/
- https://developers.whmcs.com/themes/child-themes/
- https://developers.whmcs.com/themes/order-form-templates/
- https://developers.whmcs.com/themes/css-styling/
- https://tailwindcss.com/docs/installation/tailwind-cli
