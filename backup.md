

<html>
<head>
  <meta charset="utf-8">
  <title>Carte ortho IGN</title>

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

<h2>Ortho IGN</h2>
<div id="map"></div>

<!-- Leaflet JS -->
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

<script>
  // Création de la carte centrée sur Paris
  var map = L.map("map").setView([48.8566, 2.3522], 12);

  // Couche Plan IGN (WMTS ouvert)
//   L.tileLayer(
//     "https://data.geopf.fr/wmts?SERVICE=WMTS&REQUEST=GetTile&VERSION=1.0.0" +
//       "&TILEMATRIXSET=PM&LAYER=GEOGRAPHICALGRIDSYSTEMS.PLANIGNV2" +
//       "&STYLE=normal&FORMAT=image/png" +
//       "&TILECOL={x}&TILEROW={y}&TILEMATRIX={z}",
//     {
//       maxZoom: 18,
//       attribution: "© IGN - Géoportail",
//       tileSize: 256,
//     }
//   ).addTo(map);

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

</script>

</body>
</html>