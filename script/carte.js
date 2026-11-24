// 1. Créer la carte (centre = Bayonne, zoom 13)
    const map = L.map('map').setView([43.4929, -1.4748], 13);

    // 2. Fond de carte OpenStreetMap
    L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19,
        attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>'
    }).addTo(map);

    // 3. Points de départ
    const points = [
        { nom: "Cathédrale Sainte-Marie", lat: 43.4906, lng: -1.4755 },
        { nom: "Château-Vieux",           lat: 43.4921, lng: -1.4731 }
    ];

    points.forEach(p => {
        L.marker([p.lat, p.lng]).addTo(map).bindPopup('<b>' + p.nom + '</b>');
    });

    // 4. Ajouter un point au clic
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