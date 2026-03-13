CREATE SCHEMA IF NOT EXISTS travaux;
CREATE SCHEMA IF NOT EXISTS transport;
CREATE SCHEMA IF NOT EXISTS accessibilite;

-- ======================
-- GTFS TABLES (transport)
-- ======================
CREATE TABLE transport.AGENCY(
   agency_id VARCHAR(50),
   agency_name VARCHAR(50),
   agency_url VARCHAR(50),
   agency_timezone VARCHAR(50),
   agency_lang VARCHAR(50),
   PRIMARY KEY(agency_id)
);

CREATE TABLE transport.ROUTE(
   route_id VARCHAR(50),
   route_short_name VARCHAR(50),
   route_long_name VARCHAR(50),
   route_type INTEGER,
   PRIMARY KEY(route_id)
);

CREATE TABLE transport.STOP(
   stop_id VARCHAR(50),
   stop_name VARCHAR(50),
   stop_lat DOUBLE PRECISION,
   stop_lon DOUBLE PRECISION,
   stop_id_parent VARCHAR(50),
   PRIMARY KEY(stop_id),
   FOREIGN KEY(stop_id_parent) REFERENCES transport.STOP(stop_id)
);

CREATE TABLE transport.CALENDAR(
   service_id VARCHAR(50),
   monday VARCHAR(50),
   tuesday VARCHAR(50),
   wednesday VARCHAR(50),
   thursday VARCHAR(50),
   friday VARCHAR(50),
   saturday VARCHAR(50),
   sunday VARCHAR(50),
   start_date DATE,
   end_date DATE,
   PRIMARY KEY(service_id)
);

CREATE TABLE transport.TRIP(
   trip_id VARCHAR(50),
   headsign VARCHAR(50),
   direction_id INTEGER,
   service_id VARCHAR(50) NOT NULL,
   route_id VARCHAR(50) NOT NULL,
   PRIMARY KEY(trip_id),
   FOREIGN KEY(service_id) REFERENCES transport.CALENDAR(service_id),
   FOREIGN KEY(route_id) REFERENCES transport.ROUTE(route_id)
);

CREATE TABLE transport.Gerer(
   agency_id VARCHAR(50),
   route_id VARCHAR(50),
   PRIMARY KEY(agency_id, route_id),
   FOREIGN KEY(agency_id) REFERENCES transport.AGENCY(agency_id),
   FOREIGN KEY(route_id) REFERENCES transport.ROUTE(route_id)
);

CREATE TABLE transport.Desservir(
   stop_id VARCHAR(50),
   trip_id VARCHAR(50),
   stop_sequence VARCHAR(50),
   arrival_time VARCHAR(50),
   departure_time VARCHAR(50),
   PRIMARY KEY(stop_id, trip_id),
   FOREIGN KEY(stop_id) REFERENCES transport.STOP(stop_id),
   FOREIGN KEY(trip_id) REFERENCES transport.TRIP(trip_id)
);

-- ======================
-- ACCESSIBILITY TABLES (accessibilite)
-- ======================

CREATE TABLE accessibilite.Cheminement(
   idCheminement VARCHAR(255),
   nom VARCHAR(254),
   PRIMARY KEY(idCheminement)
);

CREATE TABLE accessibilite.Obstacle(
   idObstacle VARCHAR(255),
   typeObstacle VARCHAR(2),
   largeurUtile DOUBLE PRECISION,
   positionObstacle VARCHAR(2),
   longueurObstacle DOUBLE PRECISION,
   rappelObstacle VARCHAR(2),
   reperabiliteVisuelle BOOLEAN,
   largeurObstacle DOUBLE PRECISION,
   hauteurObsPoseSol DOUBLE PRECISION,
   hauteurSousObs DOUBLE PRECISION,
   geom GEOMETRY,
   PRIMARY KEY(idObstacle)
);

CREATE TABLE accessibilite.Circulation(
   idCirculation VARCHAR(255),
   typeSol VARCHAR(2),
   largeurPassageUtile DOUBLE PRECISION,
   etatRevetement VARCHAR(2),
   eclairage VARCHAR(2),
   transition VARCHAR(2),
   typePassage VARCHAR(2),
   repereLineaire VARCHAR(2),
   couvert VARCHAR(50),
   PRIMARY KEY(idCirculation)
);

CREATE TABLE accessibilite.Ascenceur(
   idAscenseur VARCHAR(255),
   largeurUtile DOUBLE PRECISION,
   diamManoeuvreFauteuil DOUBLE PRECISION,
   largeurCabine DOUBLE PRECISION,
   longueurCabine DOUBLE PRECISION,
   boutonsEnRelief VARCHAR(2),
   annonceSonore BOOLEAN,
   signalEtage VARCHAR(2),
   boucleInducMagnet BOOLEAN,
   miroir BOOLEAN,
   eclairage INTEGER,
   voyantAlerte VARCHAR(2),
   typeOuverture VARCHAR(2),
   mainCourante VARCHAR(2),
   hauteurMainCourante DOUBLE PRECISION,
   etatRevetement VARCHAR(2),
   supervision BOOLEAN,
   autrePorteSortie VARCHAR(2),
   PRIMARY KEY(idAscenseur)
);

CREATE TABLE accessibilite.Elevateur(
   idElevateur VARCHAR(255),
   largeurUtile DOUBLE PRECISION,
   boutonsEnRelief VARCHAR(2),
   typeOuverture VARCHAR(2),
   largeurPlateforme DOUBLE PRECISION,
   longueurPlateforme VARCHAR(50),
   utilisableAutonomie BOOLEAN,
   etatRevetement VARCHAR(2),
   supervision BOOLEAN,
   autrePorteSortie VARCHAR(2),
   chargeMaximum INTEGER,
   accompagnateur VARCHAR(2),
   PRIMARY KEY(idElevateur)
);

CREATE TABLE accessibilite.Passage_Selectif(
   idPassageSelectif VARCHAR(255),
   passageMecanique BOOLEAN,
   largeurUtile REAL,
   profondeur REAL,
   contrasteVisuel BOOLEAN,
   PRIMARY KEY(idPassageSelectif)
);

CREATE TABLE accessibilite.Entree(
   idEntree VARCHAR(255),
   adresse TEXT,
   type VARCHAR(2),
   rampe VARCHAR(2),
   rampeSonnette BOOLEAN DEFAULT false,
   ascenseur BOOLEAN DEFAULT false,
   escalierNbMarche INTEGER DEFAULT 0,
   escalierMainCourante BOOLEAN DEFAULT false,
   reperabilite BOOLEAN,
   reperageEltsVitres BOOLEAN,
   signaletique BOOLEAN,
   largeurPassage REAL,
   controleAcces VARCHAR(2),
   entreeAccueilVisible BOOLEAN,
   eclairage INTEGER,
   typePorte VARCHAR(2),
   typeOuverture VARCHAR(2),
   espaceManoeuvre VARCHAR(2),
   largManoeuvreExt REAL,
   longManoeuvreExt REAL,
   largManoeuvreInt REAL,
   longManoeuvreInt REAL,
   typePoignee VARCHAR(2),
   effortOuverture INTEGER,
   PRIMARY KEY(idEntree)
);

CREATE TABLE accessibilite.Stationnement_PMR(
   idStationnement VARCHAR(255),
   typeStationnement VARCHAR(2),
   etatRevetement VARCHAR(2),
   largeurStat REAL,
   longueurStat REAL,
   bandLatSecurite BOOLEAN,
   surLongueur REAL,
   signalPMR BOOLEAN,
   marquageSol BOOLEAN,
   pente INTEGER,
   devers INTEGER,
   typeSol VARCHAR(2),
   PRIMARY KEY(idStationnement)
);

CREATE TABLE accessibilite.Escalier(
   idEscalier VARCHAR(255),
   etatRevetement geostandard.enum5,
   mainCourante geostandard.enum5,
   dispositifVigilance geostandard.enum5,
   contrasteVisuel geostandard.enum5,
   largeurUtile REAL,
   mainCouranteContinue geostandard.enum5,
   prolongMainCourante geostandard.enum5,
   nbMarches INTEGER,
   nbVoleeMarches INTEGER,
   hauteurMarche REAL,
   giron REAL,
   PRIMARY KEY(idEscalier)
);

CREATE TABLE accessibilite.Quai(
   idQuai VARCHAR(255),
   etatRevetement VARCHAR(2),
   hauteur REAL,
   largeurPassage REAL,
   signalisationPorte VARCHAR(2),
   dispositifVigilance VARCHAR(2),
   diamZoneManoeuvre REAL,
   PRIMARY KEY(idQuai)
);

CREATE TABLE accessibilite.Rampe(
   idRampe VARCHAR(255),
   etatRevetement VARCHAR(2),
   largeurUtile REAL,
   mainCourante VARCHAR(2),
   distPalierRepos REAL,
   chasseRoue VARCHAR(2),
   aireRotation VARCHAR(2),
   poidsSupporte INTEGER,
   PRIMARY KEY(idRampe)
);

CREATE TABLE accessibilite.Tapis_Roulant(
   idTapis VARCHAR(255),
   sens VARCHAR(2),
   dispositifVigilance VARCHAR(2),
   largeurUtile REAL,
   detecteur BOOLEAN,
   PRIMARY KEY(idTapis)
);

CREATE TABLE accessibilite.Escalator(
   idEscalator VARCHAR(255),
   sens geostandard.enum4,
   dispositifVigilance geostandard.enum5,
   largeurUtile REAL,
   detecteur BOOLEAN,
   surpervision BOOLEAN,
   PRIMARY KEY(idEscalator)
);

CREATE TABLE accessibilite.Traversee(
   idTraversee VARCHAR(255),
   etatRevetement VARCHAR(2),
   marquageSol VARCHAR(2),
   eclairage VARCHAR(2),
   feuPietons BOOLEAN,
   aideSonore VARCHAR(2),
   repereLineaire VARCHAR(2),
   presenceIlot BOOLEAN,
   chausseeBombee BOOLEAN,
   covisibilite VARCHAR(2),
   PRIMARY KEY(idTraversee)
);

CREATE TABLE accessibilite.Carroyage(
   idCarreau VARCHAR(50),
   ind NUMERIC(15,2),
   ind_0_3 NUMERIC(15,2),
   ind_4_5 NUMERIC(15,2),
   ind_6_10 NUMERIC(15,2),
   ind_11_17 NUMERIC(15,2),
   ind_18_24 NUMERIC(15,2),
   ind_25_39 NUMERIC(15,2),
   ind_40_54 NUMERIC(15,2),
   ind_55_64 NUMERIC(15,2),
   ind_65_79 NUMERIC(15,2),
   ind_80 NUMERIC(15,2),
   PRIMARY KEY(idCarreau)
);

-- ======================
-- TRONCONS ET NOEUDS (accessibilite)
-- ======================

CREATE TABLE accessibilite.Troncon_Cheminement(
   idTroncon VARCHAR(50),
   from_ VARCHAR(255),
   to_ VARCHAR(255),
   longueur INTEGER,
   typeTroncon VARCHAR(2),
   statutVoie VARCHAR(2),
   pente INTEGER,
   devers INTEGER,
   accessibiliteGlobale VARCHAR(2),
   geom GEOMETRY NOT NULL,
   idTraversee VARCHAR(255),
   idEscalator VARCHAR(255),
   idTapis VARCHAR(255),
   idRampe VARCHAR(255),
   idQuai VARCHAR(255),
   idEscalier VARCHAR(255),
   idCirculation VARCHAR(255),
   idObstacle VARCHAR(255),
   PRIMARY KEY(idTroncon),
   FOREIGN KEY(idTraversee) REFERENCES accessibilite.Traversee(idTraversee),
   FOREIGN KEY(idEscalator) REFERENCES accessibilite.Escalator(idEscalator),
   FOREIGN KEY(idTapis) REFERENCES accessibilite.Tapis_Roulant(idTapis),
   FOREIGN KEY(idRampe) REFERENCES accessibilite.Rampe(idRampe),
   FOREIGN KEY(idQuai) REFERENCES accessibilite.Quai(idQuai),
   FOREIGN KEY(idEscalier) REFERENCES accessibilite.Escalier(idEscalier),
   FOREIGN KEY(idCirculation) REFERENCES accessibilite.Circulation(idCirculation),
   FOREIGN KEY(idObstacle) REFERENCES accessibilite.Obstacle(idObstacle)
);

CREATE TABLE accessibilite.Noeud(
   idNoeud VARCHAR(50),
   altitude DOUBLE PRECISION,
   bandeEveilVigilance VARCHAR(2),
   hauteurRessaut DOUBLE PRECISION,
   abaissePente INTEGER,
   abaisseTrottoir DOUBLE PRECISION,
   controleBEV VARCHAR(50),
   bandeInterception BOOLEAN,
   geom GEOMETRY NOT NULL,
   idEntree VARCHAR(255) NOT NULL,
   idPassageSelectif VARCHAR(255) NOT NULL,
   idElevateur VARCHAR(255) NOT NULL,
   idAscenseur VARCHAR(255) NOT NULL,
   idCarreau VARCHAR(50) NOT NULL,
   idTroncon VARCHAR(50) NOT NULL,
   PRIMARY KEY(idNoeud),
   UNIQUE(idEntree),
   UNIQUE(idPassageSelectif),
   UNIQUE(idElevateur),
   UNIQUE(idAscenseur),
   FOREIGN KEY(idEntree) REFERENCES accessibilite.Entree(idEntree),
   FOREIGN KEY(idPassageSelectif) REFERENCES accessibilite.Passage_Selectif(idPassageSelectif),
   FOREIGN KEY(idElevateur) REFERENCES accessibilite.Elevateur(idElevateur),
   FOREIGN KEY(idAscenseur) REFERENCES accessibilite.Ascenceur(idAscenseur),
   FOREIGN KEY(idCarreau) REFERENCES accessibilite.Carroyage(idCarreau),
   FOREIGN KEY(idTroncon) REFERENCES accessibilite.Troncon_Cheminement(idTroncon)
);

-- ======================
-- RELATIONS (accessibilite)
-- ======================

CREATE TABLE accessibilite.est_compose_de(
   idTroncon VARCHAR(50),
   idCheminement VARCHAR(255),
   PRIMARY KEY(idTroncon, idCheminement),
   FOREIGN KEY(idTroncon) REFERENCES accessibilite.Troncon_Cheminement(idTroncon),
   FOREIGN KEY(idCheminement) REFERENCES accessibilite.Cheminement(idCheminement)
);

CREATE TABLE accessibilite.donne_acces_a(
   idNoeud VARCHAR(50),
   idStationnement VARCHAR(255),
   PRIMARY KEY(idNoeud, idStationnement),
   FOREIGN KEY(idNoeud) REFERENCES accessibilite.Noeud(idNoeud),
   FOREIGN KEY(idStationnement) REFERENCES accessibilite.Stationnement_PMR(idStationnement)
);

-- ======================
-- TRAVAUX TABLES (travaux)
-- ======================

CREATE TABLE travaux.zone(
   Id_zone SERIAL,
   nom_zone VARCHAR(255),
   debut DATE,
   fin DATE,
   statut VARCHAR(255),
   libelle VARCHAR(255),
   geom GEOMETRY(POLYGON,2154),
   PRIMARY KEY(Id_zone)
);

CREATE TABLE travaux.impact_accessibilite(
   Id_impact_accessibilite SERIAL,
   description VARCHAR(255),
   coupure_totale BOOLEAN,
   recommandation VARCHAR(255),
   Id_zone INTEGER NOT NULL,
   PRIMARY KEY(Id_impact_accessibilite),
   FOREIGN KEY(Id_zone) REFERENCES travaux.zone(Id_zone)
);

CREATE TABLE travaux.projet_travaux(
   Id_projet_travaux SERIAL,
   nom_chantier VARCHAR(255),
   maitrise_ouvrage VARCHAR(255),
   contact_responsable REAL,
   num_arrete VARCHAR(255),
   Id_zone INTEGER NOT NULL,
   PRIMARY KEY(Id_projet_travaux),
   FOREIGN KEY(Id_zone) REFERENCES travaux.zone(Id_zone)
);

-- Table lien entre transport.STOP et accessibilite.Noeud
CREATE TABLE transport.donner_acces_a (
    stop_id VARCHAR(50),
    idNoeud VARCHAR(50),
    PRIMARY KEY(stop_id, idNoeud),
    FOREIGN KEY(stop_id) REFERENCES transport.STOP(stop_id),
    FOREIGN KEY(idNoeud) REFERENCES accessibilite.Noeud(idNoeud)
);