<?php

declare(strict_types=1);

namespace App\Core;

/**
 * Gestion de la session : utilisateur connecté et rôle courant.
 */
class Auth
{
    /** Enregistre l'utilisateur en session après connexion. */
    public static function connecter(int $id, string $role): void
    {
        session_regenerate_id(true);
        $_SESSION['utilisateur'] = ['id' => $id, 'role' => $role];
    }

    public static function deconnecter(): void
    {
        unset($_SESSION['utilisateur']);
        session_regenerate_id(true);
    }

    public static function estConnecte(): bool
    {
        return isset($_SESSION['utilisateur']);
    }

    public static function id(): ?int
    {
        return $_SESSION['utilisateur']['id'] ?? null;
    }

    public static function role(): ?string
    {
        return $_SESSION['utilisateur']['role'] ?? null;
    }

    /**
     * Bloque l'accès si l'utilisateur n'a pas l'un des rôles demandés.
     * Sans rôle précisé, exige simplement d'être connecté.
     */
    public static function exigerRole(string ...$roles): void
    {
        if (!self::estConnecte()) {
            header('Location: index.php?page=auth&action=connexion');
            exit;
        }

        if ($roles !== [] && !in_array(self::role(), $roles, true)) {
            http_response_code(403);
            exit('Accès refusé.');
        }
    }
}
