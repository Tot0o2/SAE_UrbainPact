<?php

declare(strict_types=1);

namespace App\Controleurs;

use App\Core\Controleur;

class AccueilControleur extends Controleur
{
    public function index(): void
    {
        $this->render('accueil');
    }

    /** Page affichée par index.php quand la page ou l'action n'existe pas. */
    public function erreur404(): void
    {
        http_response_code(404);
        $this->render('erreur404');
    }
}
