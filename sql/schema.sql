CREATE TABLE categorie (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  libelle VARCHAR(80) NOT NULL UNIQUE
);
CREATE TABLE equipe (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(100) NOT NULL UNIQUE,
  service VARCHAR(100) NOT NULL
);
-- catégories prises en charge par équipe
CREATE TABLE competence (
  equipe_id INT UNSIGNED NOT NULL,
  categorie_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (equipe_id, categorie_id),
  FOREIGN KEY (equipe_id)
    REFERENCES equipe(id) ON DELETE CASCADE,
  FOREIGN KEY (categorie_id)
    REFERENCES categorie(id) ON DELETE CASCADE
);
CREATE TABLE utilisateur (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(80) NOT NULL,
  prenom VARCHAR(80) NOT NULL,
  email VARCHAR(180) NOT NULL UNIQUE,
  mot_de_passe VARCHAR(255) NOT NULL,
  ville VARCHAR(100) NOT NULL,
  role ENUM('citoyen','agent','direction')
    NOT NULL DEFAULT 'citoyen'
);
-- spécialisation : seuls les agents
-- de terrain appartiennent à une équipe
CREATE TABLE agent (
  utilisateur_id INT UNSIGNED PRIMARY KEY,
  equipe_id INT UNSIGNED NOT NULL,
  FOREIGN KEY (utilisateur_id)
    REFERENCES utilisateur(id)
    ON DELETE CASCADE,
  FOREIGN KEY (equipe_id)
    REFERENCES equipe(id)
);
CREATE TABLE signalement (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  titre VARCHAR(150) NOT NULL,
  description TEXT NOT NULL,
  latitude DECIMAL(9,6) NOT NULL,
  longitude DECIMAL(9,6) NOT NULL,
  statut ENUM('non_traite','en_cours','resolu')
    NOT NULL DEFAULT 'non_traite',
  -- signé : les votes contre retirent 1
  nb_votes INT NOT NULL DEFAULT 0,
  approuve BOOLEAN NOT NULL DEFAULT FALSE,
  date_creation DATETIME NOT NULL
    DEFAULT CURRENT_TIMESTAMP,
  date_resolution DATETIME NULL,
  utilisateur_id INT UNSIGNED NOT NULL,
  categorie_id INT UNSIGNED NOT NULL,
  FOREIGN KEY (utilisateur_id)
    REFERENCES utilisateur(id),
  FOREIGN KEY (categorie_id)
    REFERENCES categorie(id)
);
CREATE TABLE vote (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  -- +1 approuver, -1 désapprouver
  valeur TINYINT NOT NULL DEFAULT 1,
  date_vote DATETIME NOT NULL
    DEFAULT CURRENT_TIMESTAMP,
  utilisateur_id INT UNSIGNED NOT NULL,
  signalement_id INT UNSIGNED NOT NULL,
  CHECK (valeur IN (1, -1)),
  FOREIGN KEY (utilisateur_id)
    REFERENCES utilisateur(id),
  FOREIGN KEY (signalement_id)
    REFERENCES signalement(id)
    ON DELETE CASCADE
);
CREATE TABLE photo (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  chemin VARCHAR(255) NOT NULL,
  date_ajout DATETIME NOT NULL
    DEFAULT CURRENT_TIMESTAMP,
  signalement_id INT UNSIGNED NOT NULL,
  FOREIGN KEY (signalement_id)
    REFERENCES signalement(id) ON DELETE CASCADE
);
-- nb_votes suit chaque ajout et retrait
CREATE TRIGGER trg_vote_ai
AFTER INSERT ON vote FOR EACH ROW
  UPDATE signalement
  SET nb_votes = nb_votes + NEW.valeur
  WHERE id = NEW.signalement_id;
CREATE TRIGGER trg_vote_ad
AFTER DELETE ON vote FOR EACH ROW
  UPDATE signalement
  SET nb_votes = nb_votes - OLD.valeur
  WHERE id = OLD.signalement_id;
CREATE TABLE mission (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  statut ENUM('attribuee','en_cours',
    'cloturee') NOT NULL DEFAULT 'attribuee',
  date_attribution DATETIME NOT NULL
    DEFAULT CURRENT_TIMESTAMP,
  date_cloture DATETIME NULL,
  signalement_id INT UNSIGNED NOT NULL,
  equipe_id INT UNSIGNED NOT NULL,
  -- la direction qui attribue la mission
  utilisateur_id INT UNSIGNED NOT NULL,
  FOREIGN KEY (signalement_id)
    REFERENCES signalement(id)
    ON DELETE CASCADE,
  FOREIGN KEY (equipe_id)
    REFERENCES equipe(id),
  FOREIGN KEY (utilisateur_id)
    REFERENCES utilisateur(id)
);
