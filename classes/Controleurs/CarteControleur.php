<?php

declare(strict_types=1);

namespace App\Controleurs;

use App\Core\Controleur;

class CarteControleur extends Controleur
{
    public function index(): void
    {
        $this->render('carte');
    }
}