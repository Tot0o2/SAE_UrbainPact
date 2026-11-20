<?php

declare(strict_types=1);

ini_set('display_errors', '1');
error_reporting(E_ALL);

define('RACINE', __DIR__);

require_once RACINE . '/vendor/autoload.php';

spl_autoload_register(function (string $classe): void {
    $fichier = RACINE . '/classes/' . $classe . '.php';
    if (is_file($fichier)) {
        require_once $fichier;
    }
});

session_start();

$page   = $_GET['page']   ?? 'accueil';
$action = $_GET['action'] ?? 'index';

$routeur = new Routeur();
$routeur->executer($page, $action);
