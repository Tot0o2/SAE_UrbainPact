# UrbainPact

Plateforme citoyenne de signalement de problèmes urbains (SAE).

## Équipe

- Tom
- Noé
- Nino
- Milo
- Thomas
- Nourdine

## Installation

1. Installer les dépendances : `composer install` puis `npm install` (Bootstrap)
2. Copier `config/config.example.json` en `config/config.json` et remplir les identifiants BDD
3. Créer les tables : importer `sql/schema.sql` puis `sql/donnees_test.sql`
4. Lancer le serveur : `php -S localhost:8000`, puis ouvrir http://localhost:8000

## Comptes de test

_À compléter._

## Architecture

- `index.php` : contrôleur central, `index.php?page=signalement&action=liste`
  appelle `App\Controleurs\SignalementControleur::liste()`
- `classes/Core` : `Database` (PDO), `Auth` (session, rôles), `Controleur` (classe mère)
- `classes/Modeles` : une classe par table (à créer)
- `classes/Controleurs` : un contrôleur par page
- `templates` : vues Twig

Après avoir ajouté une classe dans `classes/`, rien à faire : l'autoload PSR-4 la trouve
si son namespace correspond au dossier (`App\Modeles\Vote` → `classes/Modeles/Vote.php`).
