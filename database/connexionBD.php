<?php

declare(strict_types=1);

function getDatabaseConfig(): array
{
    $host = $_ENV['DB_HOST'] ?? getenv('DB_HOST') ?: 'http://lakartxela.iutbayonne.univ-pau.fr/';
    $port = (int)($_ENV['DB_PORT'] ?? getenv('DB_PORT') ?: 3306);
    $name = $_ENV['DB_NAME'] ?? getenv('DB_NAME') ?: 'msalanova_bd';
    $user = $_ENV['DB_USER'] ?? getenv('DB_USER') ?: 'msalanova_bd';
    $password = $_ENV['DB_PASSWORD'] ?? getenv('DB_PASSWORD') ?: 'msalanova_bd';

    return [
        'host' => $host,
        'port' => $port,
        'name' => $name,
        'user' => $user,
        'password' => $password,
    ];
}

function getPDO(): PDO
{
    $config = getDatabaseConfig();

    $dsn = sprintf(
        'mysql:host=%s;port=%d;dbname=%s;charset=utf8mb4',
        $config['host'],
        $config['port'],
        $config['name']
    );

    $options = [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES => false,
        PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci',
    ];

    try {
        $pdo = new PDO($dsn, $config['user'], $config['password'], $options);
        return $pdo;
    } catch (PDOException $e) {
        error_log('Erreur de connexion DB : ' . $e->getMessage());

        http_response_code(500);
        die('Erreur de connexion à la base de données.');
    }
}