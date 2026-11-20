INSERT INTO categorie (id, libelle) VALUES
  (1, 'Voirie'),
  (2, 'Éclairage public'),
  (3, 'Propreté'),
  (4, 'Espaces verts'),
  (5, 'Mobilier urbain'),
  (6, 'Eau et assainissement');
INSERT INTO equipe (id, nom, service) VALUES
  (1, 'Équipe Voirie', 'Services techniques'),
  (2, 'Équipe Éclairage',
      'Service Énergie et éclairage'),
  (3, 'Équipe Propreté',
      'Service Environnement');
  -- … 5 équipes au total
INSERT INTO competence
  (equipe_id, categorie_id) VALUES
  (1, 1), (1, 5),  -- voirie, mobilier urbain
  (2, 2),          -- éclairage public
  (3, 3),          -- propreté
  -- … chaque catégorie a au moins une équipe
SET @mdp = '$2y$12$8xCbUKde…'; -- hash bcrypt
INSERT INTO utilisateur
  (id, nom, prenom, email,
   mot_de_passe, ville, role)
VALUES
  (1, 'Mercier', 'Claire',
   'claire.mercier@example.fr',
   @mdp, 'Bayonne', 'direction'),
  (3, 'Benali', 'Karim',
   'karim.benali@example.fr',
   @mdp, 'Bayonne', 'agent'),
  (9, 'Dubois', 'Camille',
   'camille.dubois@example.fr',
   @mdp, 'Bayonne', 'citoyen');
  -- … 20 utilisateurs au total
INSERT INTO agent (utilisateur_id, equipe_id)
VALUES
  (3, 1);  -- Karim : Équipe Voirie
  -- … une ligne par agent de terrain
INSERT INTO signalement
  (id, titre, description, latitude,
   longitude, statut, approuve,
   date_creation, date_resolution,
   utilisateur_id, categorie_id)
VALUES
  (1, 'Nid-de-poule rue d''Espagne',
   'Trou profond d''environ 40 cm…',
   43.4912, -1.4731, 'en_cours', 1,
   @debut_mois + INTERVAL 2 HOUR,
   NULL, 9, 1);
  -- … 36 signalements au total
INSERT INTO vote
  (utilisateur_id, signalement_id,
   valeur, date_vote)
VALUES
  (15, 1, 1, @debut_mois + INTERVAL 3 HOUR),
  (16, 1, 1, @debut_mois + INTERVAL 6 HOUR);
  -- … 126 votes au total
 
INSERT INTO mission
  (id, statut, date_attribution,
   date_cloture, signalement_id,
   equipe_id, utilisateur_id)
VALUES
  (1, 'en_cours',
   @debut_mois + INTERVAL 6 HOUR,
   NULL, 1, 1, 1);
  -- … 21 missions au total
