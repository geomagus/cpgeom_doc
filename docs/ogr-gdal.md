# 🌍 OGR/GDAL

---
## 1. Connexion à une BD PostgreSQL en CLI

```bash
psql -h 192.168.10.1 -p 15432 -U editeur -d lucas

\d # Lister le contenu de la BD

\dt *.* # Lister toutes les tables de tous les schémas

\dt tg.* # Lister toutes les tables du schéma 'tg'

\q # Quit psql cli client
```

&rArr; [Doc psql](https://docs.postgresql.fr/13/app-psql.html)

---
## 2. *GDAL* : Geo Data Abstraction Library

```bash

ogrinfo -so departement.shp departement >> def_dept.txt # Save info in a text file

ogr2ogr -where "INSEE_DEP='38'" dep38.shp departement.shp # Keep only one departement

gdalwarp -s_srs EPSG:2154 -t_srs EPSG:2154 -of VRT -cutline dep38.shp -cl dep38 ../raster/mnt/mnt38.vrt ../raster/mnt/mnt38_decoup.vrt

gdalinfo ortho38.tiff

gdalwarp -s_srs EPSG:3857 -t_srs EPSG:2154 -of "VRT" -r nearest -dstnodata -9999 ortho38.tiff ortho38_2154.vrt

-of # Output Format

```

### Ajout d'une couche en BDD

```bash
ogr2ogr -of "PostgreSQL" PG:"dbname=lucas user=editeur password=editeur2026 host=192.168.10.1 port=15432" -nln public.commune -nlt MULTIPOLYGON -s_srs EPSG:2154 -t_srs EPSG:2154 COMMUNE.sh  

ogr2ogr -of "PostgreSQL" PG:"dbname=lucas user=editeur password=editeur2026 host=192.168.10.1 port=15432" -nln public.dept38 -s_srs EPSG:4326 -t_srs EPSG:2154 WFS:https://data.geopf.fr/wfs/ows?SERVICE=WFS BDTOPO_V3:departement -where "code_insee='38'"
```

---
## 3. Scripter avec *GDAL*

### Script *bash* simple

```bash
#!/bin/bash

mkdir my_folder

echo "Folder created"

touch my_folder/readme.md 

echo "This is the content" >> my_folder/readme.md

echo "Content added to readme.md"
```

### Exécution du script

```bash
./script.sh # Option 1

bash script.sh # Option 2
```

### *Bash* et *GDAL*

```bash

# Créer dossier Isère
rm -rf isere
mkdir -p isere/raster/mnt && mkdir -p isere/vecteur

# Télécharger BDALTI 25m (MNT) dans le doss
wget https://data.geopf.fr/telechargement/download/BDALTI/BDALTIV2_2-0_25M_ASC_LAMB93-IGN69_D038_2020-11-13/BDALTIV2_2-0_25M_ASC_LAMB93-IGN69_D038_2020-11-13.7z -P isere/raster/mnt

# Unzip avec 7z
7z x isere/raster/mnt/BDALTIV2_2-0_25M_ASC_LAMB93-IGN69_D038_2020-11-13.7z -oisere/raster/mnt

# Créer .vrt avec *.asc
gdalbuildvrt -srcnodata -99 isere/raster/mnt/mnt.vrt isere/raster/mnt/BDALTIV2_2-0_25M_ASC_LAMB93-IGN69_D038_2020-11-13/BDALTIV2/1_DONNEES_LIVRAISON_2021-10-00008/BDALTIV2_MNT_25M_ASC_LAMB93_IGN69_D038/*.asc

# Découpe du .vrt sur un département avec source WFS --> EPSG ATTENTION
ogr2ogr -f "ESRI Shapefile" isere/vecteur/dep38.shp WFS:"https://data.geopf.fr/wfs/ows?SERVICE=WFS" BDTOPO_V3:departement -where "code_insee='38'" -s_srs EPSG:4326 -t_srs EPSG:2154

gdalwarp -s_srs EPSG:2154 -t_srs EPSG:2154 -of VRT -cutline isere/vecteur/dep38.shp -cl dep38 isere/raster/mnt/mnt.vrt isere/raster/mnt/mnt38.vrt

# Courbes de niveaux --> couche vectorielle .vrt
gdal_contour -a elev isere/raster/mnt/mnt38.vrt isere/vecteur/contour_mnt_100.shp -i 100
echo "Elevation layer generated"

# Ombrage
gdaldem hillshade isere/raster/mnt/mnt38.vrt isere/raster/mnt/ombrage38.tif
echo "Hillshade layer generated"

# Color relief
gdaldem color-relief -alpha isere/raster/mnt/mnt38.vrt color-relief.txt isere/raster/mnt/color_mnt38.tif
echo "Color relief layer generated"

```

### Résultat dans QGIS

<html>
<img style="border-radius: 15px;" src="../assets/relief_isere.png" alt="relief Isère" width="1000"/>

  <head>
      <meta charset="utf-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="initial-scale=1,user-scalable=no,maximum-scale=1,width=device-width">
      <meta name="mobile-web-app-capable" content="yes">
      <meta name="apple-mobile-web-app-capable" content="yes">
      <link rel="stylesheet" href="css/leaflet.css">
      <link rel="stylesheet" href="css/L.Control.Layers.Tree.css">
      <link rel="stylesheet" href="css/qgis2web.css">
      <link rel="stylesheet" href="css/fontawesome-all.min.css">
      <link rel="stylesheet" href="css/leaflet.photon.css">
      <style>
      html, body, #map {
          width: 100%;
          height: 100%;
          padding: 0;
          margin: 0;
      }
      </style>
      <title></title>
  </head>
  <body>
      <div id="map">
      </div>
      <script src="js/qgis2web_expressions.js"></script>
      <script src="js/leaflet.js"></script>
      <script src="js/L.Control.Layers.Tree.min.js"></script>
      <script src="js/leaflet.rotatedMarker.js"></script>
      <script src="js/leaflet.pattern.js"></script>
      <script src="js/leaflet-hash.js"></script>
      <script src="js/Autolinker.min.js"></script>
      <script src="js/rbush.min.js"></script>
      <script src="js/labelgun.min.js"></script>
      <script src="js/labels.js"></script>
      <script src="js/leaflet.photon.js"></script>
      <script>
      var map = L.map('map', {
          zoomControl:false, maxZoom:28, minZoom:1
      }).fitBounds([[44.789447870193605,4.782522148823888],[45.466227129211035,6.153089795603694]]);
      var hash = new L.Hash(map);
      map.attributionControl.setPrefix('<a href="https://github.com/tomchadwin/qgis2web" target="_blank">qgis2web</a> &middot; <a href="https://leafletjs.com" title="A JS library for interactive maps">Leaflet</a> &middot; <a href="https://qgis.org">QGIS</a>');
      var autolinker = new Autolinker({truncate: {length: 30, location: 'smart'}});
      // remove popup's row if "visible-with-data"
      function removeEmptyRowsFromPopupContent(content, feature) {
       var tempDiv = document.createElement('div');
       tempDiv.innerHTML = content;
       var rows = tempDiv.querySelectorAll('tr');
       for (var i = 0; i < rows.length; i++) {
           var td = rows[i].querySelector('td.visible-with-data');
           var key = td ? td.id : '';
           if (td && td.classList.contains('visible-with-data') && feature.properties[key] == null) {
               rows[i].parentNode.removeChild(rows[i]);
           }
       }
       return tempDiv.innerHTML;
      }
      // modify popup if contains media
      function addClassToPopupIfMedia(content, popup) {
          var tempDiv = document.createElement('div');
          tempDiv.innerHTML = content;
          var imgTd = tempDiv.querySelector('td img');
          if (imgTd) {
              var src = imgTd.getAttribute('src');
              if (/\.(jpg|jpeg|png|gif|bmp|webp|avif)$/i.test(src)) {
                  popup._contentNode.classList.add('media');
                  setTimeout(function() {
                      popup.update();
                  }, 10);
              } else if (/\.(mp3|wav|ogg|aac)$/i.test(src)) {
                  var audio = document.createElement('audio');
                  audio.controls = true;
                  audio.src = src;
                  imgTd.parentNode.replaceChild(audio, imgTd);
                  popup._contentNode.classList.add('media');
                  setTimeout(function() {
                      popup.setContent(tempDiv.innerHTML);
                      popup.update();
                  }, 10);
              } else if (/\.(mp4|webm|ogg|mov)$/i.test(src)) {
                  var video = document.createElement('video');
                  video.controls = true;
                  video.src = src;
                  video.style.width = "400px";
                  video.style.height = "300px";
                  video.style.maxHeight = "60vh";
                  video.style.maxWidth = "60vw";
                  imgTd.parentNode.replaceChild(video, imgTd);
                  popup._contentNode.classList.add('media');
                  // Aggiorna il popup quando il video carica i metadati
                  video.addEventListener('loadedmetadata', function() {
                      popup.update();
                  });
                  setTimeout(function() {
                      popup.setContent(tempDiv.innerHTML);
                      popup.update();
                  }, 10);
              } else {
                  popup._contentNode.classList.remove('media');
              }
          } else {
              popup._contentNode.classList.remove('media');
          }
      }
      var zoomControl = L.control.zoom({
          position: 'topleft'
      }).addTo(map);
      var bounds_group = new L.featureGroup([]);
      function setBounds() {
      }
      map.createPane('pane_OpenStreetMap_0');
      map.getPane('pane_OpenStreetMap_0').style.zIndex = 400;
      var layer_OpenStreetMap_0 = L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
          pane: 'pane_OpenStreetMap_0',
          opacity: 1.0,
          attribution: '',
          minZoom: 1,
          maxZoom: 28,
          minNativeZoom: 0,
          maxNativeZoom: 19
      });
      layer_OpenStreetMap_0;
      map.addLayer(layer_OpenStreetMap_0);
      map.createPane('pane_color_fusion_small_1');
      map.getPane('pane_color_fusion_small_1').style.zIndex = 401;
      var img_color_fusion_small_1 = 'data/color_fusion_small_1.png';
      var img_bounds_color_fusion_small_1 = [[44.64484361769975,4.577468049434825],[46.03835619170194,6.553955233601614]];
      var layer_color_fusion_small_1 = new L.imageOverlay(img_color_fusion_small_1,
                                            img_bounds_color_fusion_small_1,
                                            {pane: 'pane_color_fusion_small_1'});
      bounds_group.addLayer(layer_color_fusion_small_1);
      map.addLayer(layer_color_fusion_small_1);
      setBounds();
      L.ImageOverlay.include({
          getBounds: function () {
              return this._bounds;
          }
      });
      </script>        
  </body>

</html>


