<?php

declare(strict_types=1);

function getPDO(): PDO
{
    $host = $_ENV['DB_HOST'] ?? getenv('DB_HOST') ?: 'lakartxela.iutbayonne.univ-pau.fr';
    $port = $_ENV['DB_PORT'] ?? getenv('DB_PORT') ?: '3306';
    $name = $_ENV['DB_NAME'] ?? getenv('DB_NAME') ?: 'msalanova_bd';
    $user = $_ENV['DB_USER'] ?? getenv('DB_USER') ?: 'msalanova_bd';
    $password = $_ENV['DB_PASSWORD'] ?? getenv('DB_PASSWORD') ?: 'msalanova_bd';

    $dsn = "mysql:host=$host;port=$port;dbname=$name;charset=utf8mb4";

    try {
        return new PDO($dsn, $user, $password, [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES => false,
        ]);
    } catch (PDOException $e) {
        error_log('Erreur de connexion DB : ' . $e->getMessage());
        http_response_code(500);
        die('Erreur de connexion à la base de données.');
    }
}

?>