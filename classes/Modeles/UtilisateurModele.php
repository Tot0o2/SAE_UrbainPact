<?php

declare(strict_types=1);

namespace App\Modeles;

use App\Core\Database;

/**
 * Accès à la table utilisateur.
 */
class UtilisateurModele
{
    /** Retourne l'utilisateur correspondant à l'email, ou null. */
    public function trouverParEmail(string $email): ?array
    {
        $utilisateur = Database::requete(
            'SELECT * FROM utilisateur WHERE email = ?',
            [$email]
        )->fetch();

        return $utilisateur ?: null;
    }

    /** Crée un compte citoyen et retourne son id. */
    public function creer(string $nom, string $prenom, string $email, string $motDePasse, string $ville): int
    {
        Database::requete(
            'INSERT INTO utilisateur (nom, prenom, email, mot_de_passe, ville, role)
             VALUES (?, ?, ?, ?, ?, ?)',
            [$nom, $prenom, $email, password_hash($motDePasse, PASSWORD_DEFAULT), $ville, 'citoyen']
        );

        return (int) Database::pdo()->lastInsertId();
    }
}
