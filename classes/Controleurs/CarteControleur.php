<?php

declare(strict_types=1);

namespace App\Controleurs;

use App\Core\Controleur;
use App\Core\Database;

class CarteControleur extends Controleur
{
    public function index(): void
    {
        $this->render('carte');
    }

    public function signalements(): void
    {
        header('Content-Type: application/json; charset=utf-8');

        $signalements = Database::requete(
            'SELECT s.id, s.titre, s.description, s.latitude, s.longitude,
                    s.statut, s.nb_votes, s.approuve, s.date_creation,
                    c.libelle AS categorie
             FROM signalement s
             INNER JOIN categorie c ON c.id = s.categorie_id'
        )->fetchAll();

        echo json_encode($signalements, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
        exit;
    }
}