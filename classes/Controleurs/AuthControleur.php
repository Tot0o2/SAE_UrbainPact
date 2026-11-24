<?php

declare(strict_types=1);

namespace App\Controleurs;

use App\Core\Auth;
use App\Core\Controleur;
use App\Modeles\UtilisateurModele;

/**
 * Connexion, inscription et déconnexion des utilisateurs.
 */
class AuthControleur extends Controleur
{
    public function connexion(): void
    {
        if (Auth::estConnecte()) {
            $this->redirect('index.php');
        }

        $erreurs = [];
        $valeurs = ['email' => ''];

        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $valeurs['email'] = trim($_POST['email'] ?? '');
            $motDePasse = $_POST['mot_de_passe'] ?? '';

            $utilisateur = (new UtilisateurModele())->trouverParEmail($valeurs['email']);

            // Même message dans les deux cas pour ne pas révéler si l'email existe
            if ($utilisateur === null || !password_verify($motDePasse, $utilisateur['mot_de_passe'])) {
                $erreurs[] = 'Email ou mot de passe incorrect.';
            } else {
                Auth::connecter((int) $utilisateur['id'], $utilisateur['role']);
                $this->flash('success', 'Bienvenue ' . $utilisateur['prenom'] . ' !');
                $this->redirect('index.php');
            }
        }

        $this->render('auth/connexion', ['erreurs' => $erreurs, 'valeurs' => $valeurs]);
    }

    public function inscription(): void
    {
        if (Auth::estConnecte()) {
            $this->redirect('index.php');
        }

        $erreurs = [];
        $valeurs = ['nom' => '', 'prenom' => '', 'email' => '', 'ville' => ''];

        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            foreach (array_keys($valeurs) as $champ) {
                $valeurs[$champ] = trim($_POST[$champ] ?? '');
            }
            $motDePasse   = $_POST['mot_de_passe'] ?? '';
            $confirmation = $_POST['confirmation'] ?? '';
            $modele = new UtilisateurModele();

            if (in_array('', $valeurs, true)) {
                $erreurs[] = 'Tous les champs sont obligatoires.';
            }
            if (!filter_var($valeurs['email'], FILTER_VALIDATE_EMAIL)) {
                $erreurs[] = 'Adresse email invalide.';
            } elseif ($modele->trouverParEmail($valeurs['email']) !== null) {
                $erreurs[] = 'Un compte existe déjà avec cet email.';
            }
            if (strlen($motDePasse) < 8) {
                $erreurs[] = 'Le mot de passe doit faire au moins 8 caractères.';
            }
            if ($motDePasse !== $confirmation) {
                $erreurs[] = 'Les mots de passe ne correspondent pas.';
            }

            if ($erreurs === []) {
                $id = $modele->creer($valeurs['nom'], $valeurs['prenom'], $valeurs['email'], $motDePasse, $valeurs['ville']);
                Auth::connecter($id, 'citoyen');
                $this->flash('success', 'Compte créé, bienvenue sur UrbainPact !');
                $this->redirect('index.php');
            }
        }

        $this->render('auth/inscription', ['erreurs' => $erreurs, 'valeurs' => $valeurs]);
    }

    public function deconnexion(): void
    {
        // En POST uniquement : un simple lien piégé ne peut pas déconnecter l'utilisateur
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            Auth::deconnecter();
            $this->flash('info', 'Vous êtes déconnecté.');
        }
        $this->redirect('index.php');
    }
}
