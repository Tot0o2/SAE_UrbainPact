<?php

declare(strict_types=1);

namespace App\Core;

use PDO;
use PDOException;
use PDOStatement;
use RuntimeException;

/**
 * Connexion unique à la base (PDO) et exécution de requêtes préparées.
 * Les identifiants sont lus dans config/config.json.
 */
class Database
{
    private static ?PDO $pdo = null;

    /** Retourne la connexion PDO (créée au premier appel). */
    public static function pdo(): PDO
    {
        if (self::$pdo === null) {
            $db = self::config()['db'];
            $dsn = sprintf(
                'mysql:host=%s;port=%d;dbname=%s;charset=utf8mb4',
                $db['host'],
                $db['port'],
                $db['name']
            );

            try {
                self::$pdo = new PDO($dsn, $db['user'], $db['password'], [
                    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
                    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                    PDO::ATTR_EMULATE_PREPARES   => false,
                ]);
            } catch (PDOException $e) {
                error_log('Erreur de connexion BDD : ' . $e->getMessage());
                http_response_code(500);
                exit('Erreur de connexion à la base de données.');
            }
        }

        return self::$pdo;
    }

    /** Prépare et exécute une requête avec ses paramètres. */
    public static function requete(string $sql, array $params = []): PDOStatement
    {
        $stmt = self::pdo()->prepare($sql);
        $stmt->execute($params);

        return $stmt;
    }

    private static function config(): array
    {
        $fichier = RACINE . '/config/config.json';
        if (!is_file($fichier)) {
            throw new RuntimeException('config/config.json manquant : copier config/config.example.json.');
        }

        return json_decode((string) file_get_contents($fichier), true, 512, JSON_THROW_ON_ERROR);
    }
}
