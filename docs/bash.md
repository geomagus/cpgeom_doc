# Bash scripting

## Premier script

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

```bash
ogr2ogr -of "PostgreSQL" PG:"dbname=lucas user=editeur password=editeur2026 host=192.168.10.1 port=15432" -nln public.commune -nlt MULTIPOLYGON -s_srs EPSG:2154 -t_srs EPSG:2154 COMMUNE.sh # 

ogr2ogr -of "PostgreSQL" PG:"dbname=lucas user=editeur password=editeur2026 host=192.168.10.1 port=15432" -nln public.dept38 -s_srs EPSG:4326 -t_srs EPSG:2154 WFS:https://data.geopf.fr/wfs/ows?SERVICE=WFS BDTOPO_V3:departement -where "code_insee='38'"
```

### Exemple de script avec GDAL

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
[!relief_isere](../assets/relief_isere.png)

```bash
fggtrgt
```