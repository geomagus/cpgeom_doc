# La Géoplateforme de l'IGN
![Logo géoplateforme](assets/logo_geoplateforme.jpg "logo géoplateforme")

# 🌍 Géoportail / Géoplateforme de l’IGN

Bienvenue sur la page de documentation simplifiée de la **Géoplateforme de l’IGN**.  
Cette page présente les objectifs, les fonctionnalités principales et des exemples d’utilisation.

---

## 📌 1. Qu’est-ce que la Géoplateforme ?

La **Géoplateforme** est l’infrastructure nationale de diffusion des données géographiques en France.  
Elle est développée et maintenue par l’IGN (Institut national de l'information géographique et forestière).

Elle permet :

- 📡 L’accès à des données géographiques officielles
- 🗺️ La visualisation de cartes interactives
- 🔌 L’intégration de services cartographiques via API
- 📂 Le téléchargement de jeux de données

---

## 🗺️ 2. Types de données disponibles

La plateforme propose différents types de données :

### 🛰️ Orthophotos
Images aériennes haute résolution.

![Exemple d'orthophoto](https://upload.wikimedia.org/wikipedia/commons/thumb/3/3c/Orthophoto_example.jpg/640px-Orthophoto_example.jpg)

---

### 🗺️ Cartes topographiques
Cartes détaillées avec relief, routes, bâtiments, etc.

![Carte topographique](https://upload.wikimedia.org/wikipedia/commons/thumb/5/5f/Topographic_map_example.png/640px-Topographic_map_example.png)

---

### 🌊 Données altimétriques (MNT)
Modèles numériques de terrain (MNT) pour représenter le relief.

![Modèle numérique de terrain](https://upload.wikimedia.org/wikipedia/commons/thumb/e/e0/Digital_Elevation_Model_example.png/640px-Digital_Elevation_Model_example.png)

---

## 🔌 3. Services Web disponibles

La Géoplateforme fournit plusieurs services standards OGC :

| Service | Description |
|----------|-------------|
| WMS | Service de visualisation d’images cartographiques |
| WMTS | Service tuilé pour affichage rapide |
| WFS | Service d’accès aux données vectorielles |
| API REST | Accès programmatique aux données |

---

## 💻 4. Exemple d’utilisation (Leaflet + WMTS)

<html lang="fr">
<head>
  <meta charset="utf-8">
  <title>Carte Ortho IGN avec Chatbot</title>

  <!-- Leaflet CSS -->
  <link
    rel="stylesheet"
    href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"
  />
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
    }

    #chatbot {
      background: rgba(255,255,255,0.95);
      border: 1px solid #ccc;
      border-radius: 8px;
      padding: 10px;
      width: 300px;         /* largeur du chatbot */
      margin: 10px auto;    /* centre horizontalement avec un petit espace */
      box-shadow: 0 2px 8px rgba(0,0,0,0.3);
    }

    #chatbot input {
      width: calc(100% - 22px);
      padding: 5px;
      margin-top: 5px;
    }

    #chatbot button {
      margin-top: 5px;
      width: 100%;
      padding: 5px;
      background-color: #4CAF50;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }

    #chatbot button:hover {
      background-color: #45a049;
    }

    #map {
      width: 100%;
      height: 500px;
      margin-bottom: 20px;
    }
  </style>
</head>
<body>

<h2 style="text-align:center;">Carte Ortho IGN avec Chatbot</h2>

<!-- Chatbot placé juste au-dessus de la carte -->
<div id="chatbot">
  <label for="locationInput">Saisir un lieu :</label>
  <input type="text" id="locationInput" placeholder="Ex: Paris, Eiffel Tower">
  <button id="goButton">Aller à la localisation</button>
  <div id="chatOutput" style="margin-top:10px;font-size:0.9em;color:#333;"></div>
</div>

<div id="map"></div> <!-- Carte juste en dessous du chatbot -->

<!-- Leaflet JS -->
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
<script>
  // Création de la carte centrée sur Paris
  var map = L.map("map").setView([48.8566, 2.3522], 12);

  // Couche Ortho IGN
  L.tileLayer(
    "https://data.geopf.fr/wmts?SERVICE=WMTS&REQUEST=GetTile&VERSION=1.0.0" +
      "&TILEMATRIXSET=PM&LAYER=ORTHOIMAGERY.ORTHOPHOTOS" +
      "&STYLE=normal&FORMAT=image/jpeg" +
      "&TILECOL={x}&TILEROW={y}&TILEMATRIX={z}",
    {
      maxZoom: 18,
      attribution: "© IGN - Géoportail",
      tileSize: 256,
    }
  ).addTo(map);

  var marker; // Pour le marqueur dynamique

  // Fonction pour géocoder un lieu
  async function geocodePlace(place) {
    const url = `https://nominatim.openstreetmap.org/search?format=json&q=${encodeURIComponent(place)}`;
    try {
      const response = await fetch(url);
      const data = await response.json();
      if (data && data.length > 0) {
        const lat = parseFloat(data[0].lat);
        const lon = parseFloat(data[0].lon);

        // Déplacer la carte et ajouter le marqueur
        map.setView([lat, lon], 16);
        if (marker) map.removeLayer(marker);
        marker = L.marker([lat, lon]).addTo(map)
                  .bindPopup(`<b>${place}</b>`).openPopup();

        document.getElementById("chatOutput").innerText = `Localisation trouvée : ${lat.toFixed(5)}, ${lon.toFixed(5)}`;
      } else {
        document.getElementById("chatOutput").innerText = "Lieu non trouvé. Essayez une autre requête.";
      }
    } catch (error) {
      document.getElementById("chatOutput").innerText = "Erreur de géocodage.";
      console.error(error);
    }
  }

  // Événement bouton
  document.getElementById("goButton").addEventListener("click", () => {
    const place = document.getElementById("locationInput").value;
    if (place.trim() !== "") {
      geocodePlace(place);
    }
  });

  // Permet appuyer sur "Entrée" pour valider
  document.getElementById("locationInput").addEventListener("keydown", (e) => {
    if (e.key === "Enter") {
      document.getElementById("goButton").click();
    }
  });
</script>

</body>
</html>


