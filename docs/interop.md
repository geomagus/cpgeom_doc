# <a href="https://www.youtube.com/watch?v=dQw4w9WgXcQ" target="_blank">🔄</a> Intéropérabilité en géomatique

**Définition** : système capable de fonctionner avec d'autres systèmes ou produits existants ou futurs, sans restriction d'accès ou de mise en oeuvre.

- Format d'échange normalisé : **GML** (Geography Markup Language)
- Standards et spécifications : **OGC** (Open Geospatial Consortium) -- notamment des standards sur les API (OGC API)
- Directives et recommandations : **INSPIRE** , ...
- Partenariats et collaborations public/privé

<html><img src="/assets/image-1.png" alt="ogc" width="250"/></html>

## 📜 Normes

- **ISO 19115** (Métadonnées)
- **ISO 19139** (Métadonnées)
- **ISO 19157** (Qualité des données)

## ⚙️ Géo standards (OGC)

### FAIR
- Findable
- Accessible
- Interopérable
- Reusable

### Web Services (WMS, WFS, WMTS, WCS, WFS-T...)

Données mises à disposition par un **serveur cartographique** (Geoserver, Mapserver...) et directement lues sur navigateur web grâce à un **client cartographique** (OpenLayers, Leaflet...) ou sur un logiciel SIG desktop.

- WMS
- WMTS
- WFS : Web Feature Service
- WCS : Web Coverage Service
- CS-W : Catalog Service Web
- WPS : Web Processing Service

***GetCapabilities*** : retourne les métadonnées du service (couches proposées, projections associées, auteur…)

### Formats (en local)

- SLD (style associé à un Web Sevice)
- GML (Geography Markup Language)
- KML
- GPKG
- WKT CRS 

<html>
<img id="crsImg" src="/assets/crs.png" alt="crs" width="100" style="cursor:pointer;" />
</html>

## Catalogue / Métadonnées
- Données de **qualité** (exhaustives, propres, géométriquement correctes)
- Données **documentées** (normes 19115, 19139, INSPIRE)
- Données **diffusables** (catalogue)
- Données **réutilisables** (accessibles, ouvertes)

## Spatial ETL : Extract Transform Load
- Reprojection
- Transformations spatiales
- Transformations topologiques
- Re-symbolisation
- Géocodage



