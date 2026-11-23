SET FOREIGN_KEY_CHECKS = 0;

DELETE FROM mission;
DELETE FROM photo;
DELETE FROM vote;
DELETE FROM signalement;
DELETE FROM agent;
DELETE FROM competence;
DELETE FROM utilisateur;
DELETE FROM equipe;
DELETE FROM categorie;

ALTER TABLE categorie AUTO_INCREMENT = 1;
ALTER TABLE equipe AUTO_INCREMENT = 1;
ALTER TABLE utilisateur AUTO_INCREMENT = 1;
ALTER TABLE signalement AUTO_INCREMENT = 1;
ALTER TABLE vote AUTO_INCREMENT = 1;
ALTER TABLE photo AUTO_INCREMENT = 1;
ALTER TABLE mission AUTO_INCREMENT = 1;

INSERT INTO categorie (id, libelle) VALUES
  (1, 'Voirie'),
  (2, 'Éclairage public'),
  (3, 'Propreté'),
  (4, 'Espaces verts'),
  (5, 'Mobilier urbain'),
  (6, 'Eau et assainissement');

INSERT INTO equipe (id, nom, service) VALUES
  (1, 'Équipe Voirie', 'Services techniques'),
  (2, 'Équipe Éclairage', 'Service Énergie et éclairage'),
  (3, 'Équipe Propreté', 'Service Environnement'),
  (4, 'Équipe Espaces verts', 'Service Espaces verts'),
  (5, 'Équipe Eau et assainissement', 'Service Eau');

INSERT INTO competence (equipe_id, categorie_id) VALUES
  (1, 1), (1, 5),
  (2, 2),
  (3, 3),
  (4, 4),
  (5, 6);

-- Mot de passe commun des comptes de démonstration : Password123!
SET @mdp = '$2y$12$YvsYA6hMKPrSpJfuLJLq4.uTyk8sWT8E.8bcwf9i99GYJh9lIsjfC';

INSERT INTO utilisateur
  (id, nom, prenom, email, mot_de_passe, ville, role)
VALUES
  (1, 'Mercier', 'Claire', 'claire.mercier@example.fr', @mdp, 'Bayonne', 'direction'),
  (2, 'Martin', 'Thomas', 'thomas.martin@example.fr', @mdp, 'Bayonne', 'direction'),
  (3, 'Benali', 'Karim', 'karim.benali@example.fr', @mdp, 'Bayonne', 'agent'),
  (4, 'Leroy', 'Inès', 'ines.leroy@example.fr', @mdp, 'Bayonne', 'agent'),
  (5, 'Petit', 'Lucas', 'lucas.petit@example.fr', @mdp, 'Bayonne', 'agent'),
  (6, 'Robert', 'Manon', 'manon.robert@example.fr', @mdp, 'Bayonne', 'agent'),
  (7, 'Moreau', 'Nicolas', 'nicolas.moreau@example.fr', @mdp, 'Bayonne', 'agent'),
  (8, 'Laurent', 'Sarah', 'sarah.laurent@example.fr', @mdp, 'Biarritz', 'agent'),
  (9, 'Dubois', 'Camille', 'camille.dubois@example.fr', @mdp, 'Bayonne', 'citoyen'),
  (10, 'Bernard', 'Hugo', 'hugo.bernard@example.fr', @mdp, 'Bayonne', 'citoyen'),
  (11, 'Thomas', 'Léa', 'lea.thomas@example.fr', @mdp, 'Anglet', 'citoyen'),
  (12, 'Richard', 'Antoine', 'antoine.richard@example.fr', @mdp, 'Bayonne', 'citoyen'),
  (13, 'Durand', 'Emma', 'emma.durand@example.fr', @mdp, 'Biarritz', 'citoyen'),
  (14, 'Lefèvre', 'Julien', 'julien.lefevre@example.fr', @mdp, 'Anglet', 'citoyen'),
  (15, 'Garcia', 'Zoé', 'zoe.garcia@example.fr', @mdp, 'Bayonne', 'citoyen'),
  (16, 'Roux', 'Paul', 'paul.roux@example.fr', @mdp, 'Bayonne', 'citoyen'),
  (17, 'Fontaine', 'Julie', 'julie.fontaine@example.fr', @mdp, 'Biarritz', 'citoyen'),
  (18, 'Blanc', 'Maxime', 'maxime.blanc@example.fr', @mdp, 'Anglet', 'citoyen'),
  (19, 'Giraud', 'Anaïs', 'anais.giraud@example.fr', @mdp, 'Bayonne', 'citoyen'),
  (20, 'Chevalier', 'Louis', 'louis.chevalier@example.fr', @mdp, 'Bayonne', 'citoyen');

INSERT INTO agent (utilisateur_id, equipe_id) VALUES
  (3, 1),
  (4, 2),
  (5, 3),
  (6, 4),
  (7, 5),
  (8, 1);

DROP TEMPORARY TABLE IF EXISTS peuplement_chiffre;
DROP TEMPORARY TABLE IF EXISTS peuplement_numero;

CREATE TEMPORARY TABLE peuplement_numero (
  n INT UNSIGNED PRIMARY KEY
);

INSERT INTO peuplement_numero (n)
SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL
SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10 UNION ALL
SELECT 11 UNION ALL SELECT 12 UNION ALL SELECT 13 UNION ALL SELECT 14 UNION ALL SELECT 15 UNION ALL
SELECT 16 UNION ALL SELECT 17 UNION ALL SELECT 18 UNION ALL SELECT 19 UNION ALL SELECT 20 UNION ALL
SELECT 21 UNION ALL SELECT 22 UNION ALL SELECT 23 UNION ALL SELECT 24 UNION ALL SELECT 25 UNION ALL
SELECT 26 UNION ALL SELECT 27 UNION ALL SELECT 28 UNION ALL SELECT 29 UNION ALL SELECT 30 UNION ALL
SELECT 31 UNION ALL SELECT 32 UNION ALL SELECT 33 UNION ALL SELECT 34 UNION ALL SELECT 35 UNION ALL
SELECT 36 UNION ALL SELECT 37 UNION ALL SELECT 38 UNION ALL SELECT 39 UNION ALL SELECT 40 UNION ALL
SELECT 41 UNION ALL SELECT 42 UNION ALL SELECT 43 UNION ALL SELECT 44 UNION ALL SELECT 45 UNION ALL
SELECT 46 UNION ALL SELECT 47 UNION ALL SELECT 48 UNION ALL SELECT 49 UNION ALL SELECT 50 UNION ALL
SELECT 51 UNION ALL SELECT 52 UNION ALL SELECT 53 UNION ALL SELECT 54 UNION ALL SELECT 55 UNION ALL
SELECT 56 UNION ALL SELECT 57 UNION ALL SELECT 58 UNION ALL SELECT 59 UNION ALL SELECT 60 UNION ALL
SELECT 61 UNION ALL SELECT 62 UNION ALL SELECT 63 UNION ALL SELECT 64 UNION ALL SELECT 65 UNION ALL
SELECT 66 UNION ALL SELECT 67 UNION ALL SELECT 68 UNION ALL SELECT 69 UNION ALL SELECT 70 UNION ALL
SELECT 71 UNION ALL SELECT 72 UNION ALL SELECT 73 UNION ALL SELECT 74 UNION ALL SELECT 75 UNION ALL
SELECT 76 UNION ALL SELECT 77 UNION ALL SELECT 78 UNION ALL SELECT 79 UNION ALL SELECT 80 UNION ALL
SELECT 81 UNION ALL SELECT 82 UNION ALL SELECT 83 UNION ALL SELECT 84 UNION ALL SELECT 85 UNION ALL
SELECT 86 UNION ALL SELECT 87 UNION ALL SELECT 88 UNION ALL SELECT 89 UNION ALL SELECT 90 UNION ALL
SELECT 91 UNION ALL SELECT 92 UNION ALL SELECT 93 UNION ALL SELECT 94 UNION ALL SELECT 95 UNION ALL
SELECT 96 UNION ALL SELECT 97 UNION ALL SELECT 98 UNION ALL SELECT 99 UNION ALL SELECT 100 UNION ALL
SELECT 101 UNION ALL SELECT 102 UNION ALL SELECT 103 UNION ALL SELECT 104 UNION ALL SELECT 105 UNION ALL
SELECT 106 UNION ALL SELECT 107 UNION ALL SELECT 108 UNION ALL SELECT 109 UNION ALL SELECT 110 UNION ALL
SELECT 111 UNION ALL SELECT 112 UNION ALL SELECT 113 UNION ALL SELECT 114 UNION ALL SELECT 115 UNION ALL
SELECT 116 UNION ALL SELECT 117 UNION ALL SELECT 118 UNION ALL SELECT 119 UNION ALL SELECT 120 UNION ALL
SELECT 121 UNION ALL SELECT 122 UNION ALL SELECT 123 UNION ALL SELECT 124 UNION ALL SELECT 125 UNION ALL
SELECT 126;

SET @debut_mois = DATE_FORMAT(CURRENT_DATE, '%Y-%m-01');

INSERT INTO signalement
  (id, titre, description, latitude, longitude, statut, nb_votes,
   approuve, date_creation, date_resolution, utilisateur_id, categorie_id)
SELECT
  n,
  CONCAT('Signalement test n°', LPAD(n, 2, '0')),
  CONCAT('Demande de vérification n°', n,
         ' concernant un problème urbain observé dans la commune.'),
  43.480000 + ((n - 1) % 6) * 0.002,
  -1.490000 + ((n - 1) % 6) * 0.002,
  CASE
    WHEN n % 3 = 0 THEN 'resolu'
    WHEN n % 3 = 1 THEN 'en_cours'
    ELSE 'non_traite'
  END,
  0,
  n % 5 <> 0,
  TIMESTAMPADD(HOUR, (n - 1) * 3, @debut_mois),
  CASE
    WHEN n % 3 = 0
      THEN TIMESTAMPADD(DAY, 2 + (n % 10), TIMESTAMPADD(HOUR, (n - 1) * 3, @debut_mois))
    ELSE NULL
  END,
  9 + ((n - 1) % 12),
  1 + ((n - 1) % 6)
FROM peuplement_numero
WHERE n <= 36;

INSERT INTO vote
  (utilisateur_id, signalement_id, valeur, date_vote)
SELECT
  9 + ((n - 1) % 12),
  1 + ((n - 1) % 36),
  CASE WHEN n % 7 = 0 THEN -1 ELSE 1 END,
  TIMESTAMPADD(HOUR, n * 2, @debut_mois)
FROM peuplement_numero
WHERE n <= 126;

INSERT INTO photo (id, chemin, date_ajout, signalement_id)
SELECT
  n,
  CONCAT('/uploads/signalements/test-', LPAD(n, 2, '0'), '.jpg'),
  TIMESTAMPADD(HOUR, (n - 1) * 3 + 1, @debut_mois),
  n
FROM peuplement_numero
WHERE n <= 36;

INSERT INTO mission
  (id, statut, date_attribution, date_cloture, signalement_id, equipe_id, utilisateur_id)
SELECT
  n,
  CASE
    WHEN n % 3 = 0 THEN 'cloturee'
    WHEN n % 3 = 1 THEN 'en_cours'
    ELSE 'attribuee'
  END,
  TIMESTAMPADD(HOUR, n * 4, @debut_mois),
  CASE
    WHEN n % 3 = 0
      THEN TIMESTAMPADD(DAY, 3 + (n % 5), TIMESTAMPADD(HOUR, n * 4, @debut_mois))
    ELSE NULL
  END,
  n,
  CASE 1 + ((n - 1) % 6)
    WHEN 1 THEN 1
    WHEN 2 THEN 2
    WHEN 3 THEN 3
    WHEN 4 THEN 4
    WHEN 5 THEN 1
    WHEN 6 THEN 5
  END,
  CASE WHEN n % 2 = 0 THEN 2 ELSE 1 END
FROM peuplement_numero
WHERE n <= 21;

DROP TEMPORARY TABLE IF EXISTS peuplement_numero;
DROP TEMPORARY TABLE IF EXISTS peuplement_chiffre;

SET FOREIGN_KEY_CHECKS = 1;
