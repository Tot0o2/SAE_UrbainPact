<?php

/**
 * Contrôleur central : toutes les requêtes passent par ici.
 * URL : index.php?page=signalement&action=liste
 *   page   -> classe App\Controleurs\{Page}Controleur
 *   action -> méthode publique de ce contrôleur (index par défaut)
 */

declare(strict_types=1);

ini_set('display_errors', '1');
error_reporting(E_ALL);

define('RACINE', __DIR__);

require_once RACINE . '/vendor/autoload.php';

require_once RACINE . '/classes/Core/Database.php';

$page   = $_GET['page']   ?? 'accueil';
$action = $_GET['action'] ?? 'index';

$classe = 'App\\Controleurs\\' . ucfirst((string) $page) . 'Controleur';

if (
    preg_match('/^[a-z]+$/', (string) $page)
    && preg_match('/^[a-zA-Z][a-zA-Z0-9]*$/', (string) $action)
    && class_exists($classe)
    && is_callable([$controleur = new $classe(), $action])
) {
    $controleur->$action();
} else {
    (new App\Controleurs\AccueilControleur())->erreur404();
}
