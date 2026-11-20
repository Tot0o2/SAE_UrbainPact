<?php

declare(strict_types=1);

class Routeur
{
    private const PAGES = [
        'accueil'     => 'AccueilController',
        'auth'        => 'AuthController',
        'carte'       => 'CarteController',
        'compte'      => 'CompteController',
        'direction'   => 'DirectionController',
        'signalement' => 'SignalementController',
        'vote'        => 'VoteController',
    ];

    public function executer(string $page, string $action): void
    {
        if (!isset(self::PAGES[$page])) {
            $this->erreur404();
            return;
        }

        $classe = self::PAGES[$page];

        if (!class_exists($classe)) {
            $this->erreur404();
            return;
        }

        $controleur = new $classe();

        if (!$this->actionValide($controleur, $action)) {
            $this->erreur404();
            return;
        }

        $controleur->$action();
    }

    private function actionValide(object $controleur, string $action): bool
    {
        if (!preg_match('/^[a-zA-Z][a-zA-Z0-9]*$/', $action)) {
            return false;
        }

        if (!method_exists($controleur, $action)) {
            return false;
        }

        $methode = new ReflectionMethod($controleur, $action);

        return $methode->isPublic()
            && !$methode->isStatic()
            && !$methode->isConstructor()
            && $methode->getDeclaringClass()->getName() !== 'Controller';
    }

    private function erreur404(): void
    {
        http_response_code(404);
        echo '<h1>404 - Page introuvable</h1>';
        echo '<p><a href="index.php">Retour à l\'accueil</a></p>';
    }
}
