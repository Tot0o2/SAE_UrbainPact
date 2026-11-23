<?php
    include_once 'database/connexionBD.php';

    $req = getPDO()->prepare("SELECT COUNT(*) FROM utilisateur");
    $req->execute();
    $count = $req->fetchColumn();
    
    echo "Nombre d'utilisateurs dans la base de données : " . $count;
?>