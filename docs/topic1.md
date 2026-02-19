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

```html
<!DOCTYPE html>
<html>
<head>
  <title>Exemple Carte IGN</title>
  <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
  <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
</head>
<body>
  <div id="map" style="height: 500px;"></div>

  <script>
    var map = L.map('map').setView([48.8566, 2.3522], 13);

    L.tileLayer('https://wxs.ign.fr/essentiels/geoportail/wmts?...', {
      attribution: '© IGN'
    }).addTo(map);
  </script>
</body>
</html>
```
