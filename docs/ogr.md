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

