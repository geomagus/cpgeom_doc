# Administration de bases de données

[Astuce adresse IP](https://monip.io/)<br>
**Bonne pratique** : ne pas exposer le port **5432** car port par défaut et bien connu des attaques.

## A) Concept d'administration

- base de **dev** / base de **prod** &rarr; idéalement 2 serveurs distincts (2 instances)


## B) Etapes de la création d'un système de base de données

**1.** Etablir les caractéristiques de la base<br>
**2.** Evaluation du matériel du serveur<br>
**3.** Installation du logiciel PostgreSQL (serveur et client)<br>
**4.** Créer et ouvrir la base de données
- Création d'un groupe de bases de données appelé **CLUSTER** (= ***instance***)
- Définition des **TABLESPACES** à l'intérieur du répertoire<br>

**5.** Stratégie de sauvegarde de la BDD
- sauv. manuelle avec *pg_dump*
- sauv. automatisée par script<br>

&rarr; Journaux de transactions appelés **WAL**<br>

**6.** Créer et gérer les utilisateurs et leurs droits d'accès<br>

&rarr; Limite max du nombre d'utilisateurs dans le fichier 'postgresql.conf'<br>

**7.** Implémenter la base<br>

&rarr; Imaginer une phase de maintenance/test avant la mise en production.<br>

**8.** Sauvegarde de base de données fonctionnelle<br>

**9.** Optimiser les performances de la base<br>

&rarr; ***PGTune***

## C) Architecture et arborescence

Avant toute modification d'un fichier .conf, le copier à l'état initial :
```bash
sudo cp /etc/postgresql/16/main/pg_hba.conf /etc/postgresql/16/main/pg_hba_ini.conf
```

Processus en cours d'utilisation sur la machine (équivalent des "services" sur Windows) :
```bash
ps -aux | grep postgres

htop
```

### Binaires pour la sauvegarde :
- *pg_dump* (sauvegarde d'une instance, différents formats, différents niveaux d'objets)
- *pg_dumpall* (sauvagarde également les **rôles**)
- *pg_restore* (à partir d'un *pg_dumpall*)

### Indexation

- Index spatial (*GIST*)
- **Réindexation** = opération de maintenance courante
- 

## D) Focus sur les Tablespaces 

Un tablespace est un **espace de stockage** dans lequel des données composant les bases de données peuvent être enregistrées. Il fournit une couche d'abstraction entre les données logiques et les données physiques.

### En PSQL


```sql
CREATE TABLESPACE nom_du_tbsp OWNER user_name LOCATION '/emplacement/tablespace/';

\db # Lister les tablespaces
\db+ # Lister avec taille
```

```sh
sudo chown postgres:postgres tablespace/ # Donner la propriété du dossier tablespace à "postgres"
```




### Bonnes pratiques
- création d'un dossier par base
- création de plusieurs Tablespaces par base possible ????????????
- Séparation des tables et indexes sur des Tablespaces différents (car l'indexation est gourmande en ressources)

Il est envisageable de stocker les indexes sur un disque rapide type SSD et les tables sur disque mécanique (HDD).

## E) Le rôle de DBA

## F) Manipulations diverses

### Maintenance

Lors des opérations normales de PostgreSQL, les lignes supprimées ou rendues obsolètes par une mise à jour ne sont pas physiquement supprimées de leur table.

Vacuum permet de récupérer l'espace occupé par les lignes supprimées.

Le VACCUM standard (sans FULL) récupère simplement l'espace et le rend disponible pour une réutilisation. Cette forme de la commande peut opérer en parallèle avec les opérations normales de lecture et d'écriture de la table, car elle n'utilise pas de verrou exclusif.

VACCUM FULL fait un traitement plus complet et, en particulier, déplace des lignes dans d'autres blocs pour compacter la table au maximum sur le disque. Cette forme est beaucoup plus lente et pose un verrou exclusif sur la table pour faire son traitement.

Il est recommandé que les bases de données actives de production soient traitées par VACUUM fréquemment (au moins toutes les nuits), pour supprimer les lignes mortes.

### Exécuter un script PSQL

```sql
DROP DATABASE IF EXISTS rugby_top;
-- Créer la base de données "rugby_top" avec l'extension PostGIS
CREATE DATABASE rugby_top TABLESPACE mine;
\c rugby_top;
CREATE EXTENSION postgis;

-- Créer la table "clubs_rugby" avec un champ géométrique "geom"
CREATE TABLE clubs_rugby (
    id SERIAL PRIMARY KEY,
    nom_club VARCHAR(255) NOT NULL,
    ville VARCHAR(255) NOT NULL,
    latitude NUMERIC,
    longitude NUMERIC,
    geom GEOMETRY(Point, 4326)
);

-- Création de l'index spatail sur geom
CREATE INDEX idx_club_geom ON clubs_rugby USING gist (geom);

-- Insérer les données des 14 clubs du Top 14 avec leurs coordonnées géographiques
INSERT INTO clubs_rugby (nom_club, ville, latitude, longitude, geom)
VALUES
('Stade Toulousain', 'Toulouse', 43.6047, 1.4442, ST_SetSRID(ST_MakePoint(1.4442, 43.6047), 4326)),
('Union Bordeaux-Bègles', 'Bordeaux', 44.8378, -0.5792, ST_SetSRID(ST_MakePoint(-0.5792, 44.8378), 4326)),
('Stade Rochelais', 'La Rochelle', 46.1603, -1.1511, ST_SetSRID(ST_MakePoint(-1.1511, 46.1603), 4326)),
('ASM Clermont Auvergne', 'Clermont-Ferrand', 45.7772, 3.0870, ST_SetSRID(ST_MakePoint(3.0870, 45.7772), 4326)),
('RC Toulon', 'Toulon', 43.1242, 5.9280, ST_SetSRID(ST_MakePoint(5.9280, 43.1242), 4326)),
('Racing 92', 'Nanterre', 48.8924, 2.2066, ST_SetSRID(ST_MakePoint(2.2066, 48.8924), 4326)),
('Stade Français Paris', 'Paris', 48.8412, 2.2530, ST_SetSRID(ST_MakePoint(2.2530, 48.8412), 4326)),
('Castres Olympique', 'Castres', 43.6062, 2.2400, ST_SetSRID(ST_MakePoint(2.2400, 43.6062), 4326)),
('Montpellier Hérault Rugby', 'Montpellier', 43.6110, 3.8767, ST_SetSRID(ST_MakePoint(3.8767, 43.6110), 4326)),
('Section Paloise', 'Pau', 43.2951, -0.3700, ST_SetSRID(ST_MakePoint(-0.3700, 43.2951), 4326)),
('Aviron Bayonnais', 'Bayonne', 43.4929, -1.4748, ST_SetSRID(ST_MakePoint(-1.4748, 43.4929), 4326)),
('USA Perpignan', 'Perpignan', 42.6986, 2.8956, ST_SetSRID(ST_MakePoint(2.8956, 42.6986), 4326)),
('LOU Rugby', 'Lyon', 45.7600, 4.8320, ST_SetSRID(ST_MakePoint(4.8320, 45.7600), 4326)),
('Oyonnax Rugby', 'Oyonnax', 46.2598, 5.6556, ST_SetSRID(ST_MakePoint(5.6556, 46.2598), 4326));

-- Afficher la structure de la table
\d clubs_rugby;

-- Voir le tablespace des base \l+
\l+
```

```bash
psql -U postgres -p 5432 -f /mnt/d/top_14.sql
```

```bash
# Response
CREATE DATABASE
You are now connected to database "rugby_top" as user "postgres".
CREATE EXTENSION
CREATE TABLE
CREATE INDEX
INSERT 0 14
                                     Table "public.clubs_rugby"
  Column   |          Type          | Collation | Nullable |                 Default
-----------+------------------------+-----------+----------+-----------------------------------------
 id        | integer                |           | not null | nextval('clubs_rugby_id_seq'::regclass)
 nom_club  | character varying(255) |           | not null |
 ville     | character varying(255) |           | not null |
 latitude  | numeric                |           |          |
 longitude | numeric                |           |          |
 geom      | geometry(Point,4326)   |           |          |
Indexes:
    "clubs_rugby_pkey" PRIMARY KEY, btree (id)
    "idx_club_geom" gist (geom)
```

```bash
psql -U postgres -d rugby_top -p 5432
```

### Sauvegarde *pg_dump*

```bash
pg_dump base_de_donnees > fichier_sauvegarde -- Dump

psql base_de_donnees < fichier_sauvegarde -- Restaurer

pg_dump -h serveur1 base_de_donnees | psql -h serveur2 base_de_donnees -- Dump une base d'un serveur à un autre
```

**Exemple de dump :**
```bash
pg_dump -f rugby_sauv.sql -d rugby_top -p 5432 -U postgres
```

**Exemple de restore :**
```bash
dropdb idgeo_locale -U postgres -p 5432 # (Wrapper)

psql -U postgres -p 5432 -c "CREATE DATABASE idgeo_locale;" # Créer une DB pour accueillir la sauvegarde -- Version 1

createdb idgeo_locale -U postgres -p 5432 # Version 2 (Wrapper)

psql -d idgeo_locale -U postgres -p 5432 < sauv_idgeo.sql # Charger le fichier de sauvegarde

\dt admin.* # Verif que la sauvegarde a été chargée dans le schéma admin
```

```sql
select id, nom from admin.departement;
```

**Script + crontab :**

```bash
nano script_sauv_bdd.sh

chmod a+x script_sauv_bdd.sh # Donne à tous les users le droit d'exécution

crontab -e # Modifier les tâches planifiées

crontab -l # Voir la liste des tâches planifiées
```

```cron
# m h  dom mon dow   command
55 * * * * /home/idgeo/script_sauv_bdd.sh # S'exécute toutes les heures à xxh55
```

```cron
 # Example of job definition:
# .---------------- minute (0 - 59)
# |  .------------- hour (0 - 23)
# |  |  .---------- day of month (1 - 31)
# |  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ...
# |  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
# |  |  |  |  |
# *  *  *  *  *  user command to be executed
```

### Sauvegarde *pg_dumpall*

**Restore :**
```bash
psql -U postgres -p 5432 < /mnt/d/dump_all_serveur_distant.sql
```

## G) Gestion des rôles

### Spécificité d'un rôle de groupe : le "NOLOGIN"

```sql
CREATE ROLE pg_monitor WITH
  NOLOGIN
```

### Spécificité d'un rôle de connexion (**utilisateur**) : le "LOGIN"

```sql
CREATE ROLE editeur WITH
  LOGIN
```

L'attribut NOINHERIT enlève à un utilisateur l'héritage des droits des groupes dont il est membre.

### Privilèges

Un privilège est un droit sur un objet de la base attribué à un rôle.

**Règle n°0** : un mot de passe pour chacun

Tous les utilisateurs (clients, applications) doivent avoir un mot de passe.

**Règle n°1** : attribution du moindre privilège.

Les utilisateurs ne doivent avoir que le minimum de droits, ceux strictement nécessaires à l'accomplissement de leurs tâches. Les privilèges peuvent évoluer au cours du temps car les besoins et les tâches affectées ne sont pas immuables, mais à un moment donné, seuls les droits indispensables doivent être fournis à un utilisateur.

Il faut éviter de créer plusieurs comptes avec des droits d'administrateur.

**Règle n°2** : contrôle de la population.

Le personnel d'une entreprise bouge, il y a des départs, des arrivées, des promotions... Les privilèges doivent êtres synchrones avec la réalité de la population : il faut supprimer les comptes des utilisateurs quittant l'entreprise et de ceux n'étant plus affectés à telle ou telle tâche.

**Règle n°3** : supervision de la délégation des tâches d'administration.

Un administrateur peut être amené à déléguer auprès d'une autre personne les tâches d'attribution des privilèges de tout ou partie de la population des utilisateurs (cf WITH GRANT OPTION). Un contrôle a posteriori doit être réalisé afin de vérifier que le résultat de cette délégation est conforme à la politique adoptée.

**Règle n°4** : contrôle physique des connexions.

La connexion d'un utilisateur à une base de données peut être réalisée depuis n'importe où dans le monde grâce à Internet. Il est nécessaire de restreindre les connexions à des hôtes spécifiques connus (hba_conf).

## H) FWD : Foreign Data Wrappers

Le FDW (Foreign Data Wrapper) natif de PostgreSQL postgres_fdw permet d'accéder aux tables à partir de serveurs PostgreSQL distants de manière très transparente.

```sql
--création d'un lien vers la base de données bd_test_postgis
CREATE SERVER foreign_bd
        FOREIGN DATA WRAPPER postgres_fdw
        OPTIONS (host 'localhost', port '5434', dbname 'bd_test_postgis');
--associer un utilisateur de la base de données distant à un utilisateur en local
CREATE USER MAPPING FOR postgres --utilisateur local
        SERVER foreign_bd
        OPTIONS (user 'postgres', password 'postgres'); --utilisateur distant
--création d'un table ayant la même structure que la table distante		
CREATE FOREIGN TABLE foreign_parkings (
    osm_id integer NOT NULL,
    date_heure timestamp without time zone,
    nom character varying ,
    type_obj character varying,
    xcoord double precision,
    ycoord double precision,
    geom geometry(Point,2154)
)
    SERVER foreign_bd
        OPTIONS (schema_name 'parkings', table_name 't_parking');
select * from foreign_parkings;
```

