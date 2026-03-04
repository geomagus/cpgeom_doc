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

Processus en cours d'utilisation :
```bash
ps -aux | grep postgres

htop
```

## D) Focus sur les Tablespaces

## E) Le rôle de DBA

## F) Manipulations diverses