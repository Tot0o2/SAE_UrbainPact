// 1. Créer la carte (centre = Bayonne, zoom 13)
    const map = L.map('map').setView([43.4929, -1.4748], 13);

    // 2. Fond de carte OpenStreetMap
    L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19,
        attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>'
    }).addTo(map);

    // 4. Récupération des signalements depuis la base de données
    fetch('index.php?page=carte&action=signalements')
        .then(response => {
            if (!response.ok) {
                throw new Error('Erreur HTTP : ' + response.status);
            }
            return response.json();
        })
        .then(signalements => {
            signalements.forEach(signalement => {
                const latitude = Number(signalement.latitude);
                const longitude = Number(signalement.longitude);

                if (!Number.isFinite(latitude) || !Number.isFinite(longitude)) {
                    return;
                }

                const contenu = `
                    <b>${signalement.titre}</b><br>
                    ${signalement.description}<br>
                    <b>Catégorie :</b> ${signalement.categorie}<br>
                    <b>Statut :</b> ${signalement.statut}<br>
                    <b>Votes :</b> ${signalement.nb_votes}
                `;

                L.marker([latitude, longitude])
                    .addTo(map)
                    .bindPopup(contenu);
            });
        })
        .catch(error => {
            console.error('Impossible de charger les signalements :', error);
        });

    // 5. Ajouter un point au clic
    map.on('click', (e) => {
        const lat = e.latlng.lat;
        const lng = e.latlng.lng;

        L.marker([lat, lng])
            .addTo(map)
            .bindPopup('Point ajouté<br>' + lat.toFixed(5) + ', ' + lng.toFixed(5))
            .openPopup();

        // Pour l'enregistrer côté Symfony :
        // fetch('/api/points', {
        //     method: 'POST',
        //     headers: { 'Content-Type': 'application/json' },
        //     body: JSON.stringify({ lat: lat, lng: lng })
        // });
    });