<?php

declare(strict_types=1);

namespace App\Core;

use Twig\Environment;
use Twig\Loader\FilesystemLoader;

/**
 * Classe mère de tous les contrôleurs : rendu Twig, redirections, messages flash.
 */
abstract class Controleur
{
    private static ?Environment $twig = null;

    /** Affiche un template Twig (chemin relatif à templates/, sans extension). */
    protected function render(string $template, array $donnees = []): void
    {
        echo self::twig()->render($template . '.html.twig', $donnees);
    }

    protected function redirect(string $url): never
    {
        header('Location: ' . $url);
        exit;
    }

    /** Ajoute un message affiché une seule fois à la prochaine page (type Bootstrap : success, danger…). */
    protected function flash(string $type, string $message): void
    {
        $_SESSION['flash'][] = ['type' => $type, 'message' => $message];
    }

    private static function twig(): Environment
    {
        if (self::$twig === null) {
            self::$twig = new Environment(new FilesystemLoader(RACINE . '/templates'), [
                'cache'            => false,
                'strict_variables' => true,
            ]);
            self::$twig->addGlobal('auth', [
                'connecte' => Auth::estConnecte(),
                'role'     => Auth::role(),
            ]);
        }

        // Les messages flash sont lus puis vidés à chaque rendu
        self::$twig->addGlobal('flashs', $_SESSION['flash'] ?? []);
        unset($_SESSION['flash']);

        return self::$twig;
    }
}
