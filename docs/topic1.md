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

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Carte IGN Open Sans Clé</title>

  <!-- Leaflet CSS -->
  <link
    rel="stylesheet"
    href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"
  />
  <style>
    #map {
      width: 100%;
      height: 500px;
    }
  </style>
</head>
<body>

<h2>Fond IGN (Plan / Orthophotos) sans clé</h2>
<div id="map"></div>

<!-- Leaflet JS -->
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

<script>
  // Création de la carte centrée sur Paris
  var map = L.map("map").setView([48.8566, 2.3522], 12);

  // Couche Plan IGN (WMTS ouvert)
  L.tileLayer(
    "https://data.geopf.fr/wmts?SERVICE=WMTS&REQUEST=GetTile&VERSION=1.0.0" +
      "&TILEMATRIXSET=PM&LAYER=GEOGRAPHICALGRIDSYSTEMS.PLANIGNV2" +
      "&STYLE=normal&FORMAT=image/png" +
      "&TILECOL={x}&TILEROW={y}&TILEMATRIX={z}",
    {
      maxZoom: 18,
      attribution: "© IGN - Géoportail",
      tileSize: 256,
    }
  ).addTo(map);

  // Décommenter si tu veux ajouter aussi les orthophotos
  /*
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
  */
</script>

</body>
</html>

