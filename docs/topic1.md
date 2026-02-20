# 📍 Sources de données 

## 1. Données satellitaires                                    

### 🔭 Imagerie optique

<div style="
  display: flex;
  gap: 20px;
  justify-content: space-between;
  flex-wrap: nowrap; /* Ne jamais passer à la ligne */
  overflow-x: auto; /* Permet de scroller si écran trop petit */
  margin-bottom: 20px;
">
  <img src="../assets/spot.jpg" alt="SPOT"
       style="flex: 1; min-width: 200px; max-width: 33%; height: auto; border-radius: 15px; box-shadow: 0 6px 15px rgba(0,0,0,0.15); transition: transform 0.3s ease; cursor: pointer;"
       onmouseover="this.style.transform='scale(1.05)'" 
       onmouseout="this.style.transform='scale(1)'">

  <img src="../assets/pleiades.jpg" alt="Pléiades"
       style="flex: 1; min-width: 200px; max-width: 33%; height: auto; border-radius: 15px; box-shadow: 0 6px 15px rgba(0,0,0,0.15); transition: transform 0.3s ease; cursor: pointer;"
       onmouseover="this.style.transform='scale(1.05)'" 
       onmouseout="this.style.transform='scale(1)'">

  <img src="../assets/neo.jpg" alt="Pléiades Neo"
       style="flex: 1; min-width: 200px; max-width: 33%; height: auto; border-radius: 15px; box-shadow: 0 6px 15px rgba(0,0,0,0.15); transition: transform 0.3s ease; cursor: pointer;"
       onmouseover="this.style.transform='scale(1.05)'" 
       onmouseout="this.style.transform='scale(1)'">
</div>
<br>

| Constellation | Résolution | Fauchée | Capacité d'acqusition journalière
|----------|-------------|-------------|-----------------|
| **SPOT** | 1,5 m | 60 km | 3.000.000 km2 |
| **Pléiades** | 70 cm | 20 km | 700.000 km2 |
| **Pléiades Neo** | 30 cm | 14 km | 1.000.000 km2 |


### 📡 Imagerie radar (SAR)
L'imagerie radar est principalement utilisée pour la détection de mouvements de terrain ou pour permettre l'observation de la Terre quelque soit la météo. 

---
## 2. Métadonnées et catalogues

Les méta-données jouent un rôle central dans les missions du service géomatique. Elles sont la colonne vertébrale des solutions suivantes, développées en interne :

- **Catalogues de métadonnées** (ex. ISO 19115)  
- **Services OGC** (WMS, WFS, CSW)  
- **API de services géospatiaux**

Ces outils facilitent la **recherche, l’interopérabilité et la diffusion** des données satellitaires.

---

## 3. Données publiques & Open Data

Le service géomatique s’appuie régulièrement sur des sources **libres ou institutionnelles**, telles que les données OpenStreetMap (OSM) et les données de référence suivantes :

### 🗺️ Données de référence de l'IGN

- **BD TOPO®**
<html>
<head>
  <meta charset="utf-8">
  <title>BD TOPO</title>

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


</script>

</body>
</html>

- **BD ORTHO®** 

<html>
<head>
  <meta charset="utf-8">
  <title>BD ORTHO</title>

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

<div id="map2"></div>

<!-- Leaflet JS -->
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

<script>
  // Création de la carte centrée sur Paris
  var map2 = L.map("map").setView([48.8566, 2.3522], 12);


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
  ).addTo(map2);

</script>

</body>
</html>
 


---

