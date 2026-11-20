<?php

declare(strict_types=1);

abstract class Controller
{
    protected function afficher(string $vue, array $donnees = []): void
    {
        Vue::afficher($vue . '.html.twig', $donnees);
    }
}
