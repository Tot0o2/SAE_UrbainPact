<?php

declare(strict_types=1);

class AccueilController extends Controller
{
    public function index(): void
    {
        $this->afficher('accueil', [
            'titre' => 'Accueil',
        ]);
    }
}
