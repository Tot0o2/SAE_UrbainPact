<?php

declare(strict_types=1);

use Twig\Environment;
use Twig\Loader\FilesystemLoader;

class Vue
{
    private static ?Environment $twig = null;

    public static function afficher(string $template, array $donnees = []): void
    {
        echo self::twig()->render($template, $donnees);
    }

    private static function twig(): Environment
    {
        if (self::$twig === null) {
            $loader = new FilesystemLoader(RACINE . '/views');
            self::$twig = new Environment($loader, [
                'cache' => false,
                'strict_variables' => true,
            ]);
        }

        return self::$twig;
    }
}
