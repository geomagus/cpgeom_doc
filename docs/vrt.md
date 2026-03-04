# ⚙️ VRT

---
## 1. GDAL/OGR

Capacité de lire et écrire dans un très grand nombre de formats géospatiaux.
- **GDAL** : Raster
- **OGR** : Vecteur
  - ogr2ogr
  - ogrinfo
  
---
## 2. VRT

- Version *Raster* ou *Vecteur*

---
## 3. Install

**WSL**
```sh
sudo apt install gdal-bin
```

```sh
ogrinfo -so -al file.vrt
```

---
## 4. Generate a .vrt from .csv

```sh
ogr2vrt_cli generate-vrt -d -o fr-en-boursiers-par-departement.vrt fr-en-boursiers-par-departement.csv
```