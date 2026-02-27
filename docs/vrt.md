# ⚙️ VRT

## GDAL/OGR
Capacité de lire et écrire dans un très grand nombre de formats géospatiaux.
- **GDAL** : Raster
- **OGR** : Vecteur
  - ogr2ogr
  - ogrinfo

## VRT
- Version *Raster* ou *Vecteur*

## Install

**WSL**
```sh
sudo apt install gdal-bin
```

```sh
ogrinfo -so -al file.vrt
```

## Generate a .vrt from .csv

```sh
ogr2vrt_cli generate-vrt -d -o fr-en-boursiers-par-departement.vrt fr-en-boursiers-par-departement.csv
```