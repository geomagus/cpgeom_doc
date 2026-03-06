# 🌍 OGR/GDAL

---
## 1. Connexion à une BD PostgreSQL en CLI

```bash
psql -h 192.168.10.1 -p 15432 -U editeur -d lucas

\d # Lister le contenu de la BD 

\d nom_table # Afficher les colonnes d'une tables

\dt *.* # Lister toutes les tables de tous les schémas

\dt tg.* # Lister toutes les tables du schéma 'tg'

\dn # Lister tous les schémas (sans les ta\ dtbles)

\q # Quit psql cli client

\l # liste TOUTES LES BD avec info (tablespaces etc)

\du # lister les utilisateurs

\c ma_base # se connecter à une BD spécifique du serveur
```

### Gérer une instance PostgreSQL dans linux

```bash
sudo apt installe postgresql

sudo systemctl disable postgresql.service

sudo systemctl start postgresql.service

sudo systemctl status postgresql.service

psql postgres postgres -p 5432
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
<a href="../assets/relief_isere.png" target="_blank"><img style="border-radius: 15px;" src="../assets/relief_isere.png" alt="relief Isère" width="1000"/></a>
</html>
