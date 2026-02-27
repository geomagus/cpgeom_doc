# OGR/GDAL

## Connexion à la BD PostgreSQL en CLI

```bash
psql -h 192.168.10.1 -p 15432 -U editeur -d lucas

\d # Lister le contenu de la BD

\dt *.* # Lister toutes les tables de tous les schémas

\dt tg.* # Lister toutes les tables du schéma 'tg'

\q # Quit psql cli client
```

&rArr; [Doc psql](https://docs.postgresql.fr/13/app-psql.html)

## GDAL

**Geo Data Abstraction Library**

```bash

ogrinfo -so departement.shp departement >> def_dept.txt # Save info in a text file

ogr2ogr -where "INSEE_DEP='38'" dep38.shp departement.shp # Keep only one departement

gdalwarp -s_srs EPSG:2154 -t_srs EPSG:2154 -of VRT -cutline dep38.shp -cl dep38 ../raster/mnt/mnt38.vrt ../raster/mnt/mnt38_decoup.vrt

gdalinfo ortho38.tiff

gdalwarp -s_srs EPSG:3857 -t_srs EPSG:2154 -of "VRT" -r nearest -dstnodata -9999 ortho38.tiff ortho38_2154.vrt

-of # Output Format

```




