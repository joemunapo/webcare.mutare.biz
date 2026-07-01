<?php

add_hook('ClientAreaHeadOutput', 1, function (array $vars): string {
    $template = (string) ($vars['template'] ?? '');
    $cartTemplate = (string) ($vars['carttpl'] ?? '');

    if ($template !== 'webcare' && $cartTemplate !== 'webcare_cart') {
        return '';
    }

    $cssPath = ROOTDIR . '/templates/webcare/css/custom.css';
    $version = is_file($cssPath) ? (string) filemtime($cssPath) : '1';

    return '<link rel="stylesheet" href="/templates/webcare/css/custom.css?v=' . htmlspecialchars($version, ENT_QUOTES, 'UTF-8') . '">' . PHP_EOL;
});
