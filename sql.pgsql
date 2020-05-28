CREATE SCHEMA IF NOT EXISTS na17p2;
SET search_path TO na17p2;

DROP TYPE IF EXISTS T_adhésion CASCADE;
DROP TABLE IF EXISTS Roles CASCADE;
DROP TABLE IF EXISTS Utilisateur CASCADE;
DROP TABLE IF EXISTS Role_utilisateur CASCADE;
DROP TABLE IF EXISTS Adhésion CASCADE;
DROP TABLE IF EXISTS Donateur CASCADE;
DROP TABLE IF EXISTS Donateur_utilisateur CASCADE;
DROP TABLE IF EXISTS Don CASCADE;
DROP TABLE IF EXISTS Fichier CASCADE;
DROP TABLE IF EXISTS PP CASCADE;
DROP TABLE IF EXISTS Groupe CASCADE;
DROP TABLE IF EXISTS Membre_groupe CASCADE;
DROP TABLE IF EXISTS Fichier_groupe CASCADE;
DROP TABLE IF EXISTS URL CASCADE;
DROP TABLE IF EXISTS URL_groupe CASCADE;
DROP TABLE IF EXISTS Evt CASCADE;
DROP TABLE IF EXISTS Evt_groupe CASCADE;
DROP TABLE IF EXISTS archive_utilisateur CASCADE;
DROP TABLE IF EXISTS archive_role_utilisateur CASCADE;
DROP TABLE IF EXISTS archive_adhésion CASCADE;
DROP TABLE IF EXISTS archive_donateur CASCADE;
DROP TABLE IF EXISTS archive_donateur_utilisateur CASCADE;
DROP TABLE IF EXISTS archive_don CASCADE;
DROP VIEW IF EXISTS viewProfilUtilisateur CASCADE;
DROP VIEW IF EXISTS viewAdhérantsActuels CASCADE;
DROP VIEW IF EXISTS viewExAdhérants CASCADE;
DROP VIEW IF EXISTS viewAdhésionExpirant CASCADE;
DROP VIEW IF EXISTS viewHistoriqueAdhésion CASCADE;
DROP VIEW IF EXISTS viewMembreGroupe CASCADE;
DROP VIEW IF EXISTS viewInfoGroupe CASCADE;
DROP VIEW IF EXISTS viewDonateursDons CASCADE;
DROP VIEW IF EXISTS viewDonateursUtilisateurs CASCADE;
DROP VIEW IF EXISTS viewArchiveProfilUtilisateur CASCADE;
DROP VIEW IF EXISTS viewArchiveAdhésions CASCADE;
DROP VIEW IF EXISTS viewArchiveDons CASCADE;
DROP VIEW IF EXISTS viewArchiveDonateursDons CASCADE;
DROP VIEW IF EXISTS viewArchiveDonateursUtilisateurs CASCADE;

CREATE TYPE T_adhésion AS ENUM ('Bronze', 'Argent', 'Or'); 

CREATE TABLE Roles(
	id_role BIGSERIAL,
	nom_role VARCHAR(50),
	PRIMARY KEY (id_role)
);

CREATE TABLE Utilisateur(
	id_user BIGSERIAL,
	nom VARCHAR(30) NOT NULL,
	prenom VARCHAR(30) NOT NULL,
	mdp VARCHAR(255) NOT NULL,
	vnom BOOL NOT NULL,
	vprenom BOOL NOT NULL,
	vphoto BOOL NOT NULL,
	date_inscription DATE NOT NULL,
	date_derniere_connexion DATE NOT NULL,
	adresse VARCHAR(60),
    email VARCHAR(20),
    phone VARCHAR(10),
    website VARCHAR(20),
	PRIMARY KEY (id_user)
);

CREATE TABLE Role_utilisateur(
	id_role BIGSERIAL,
	id_user BIGSERIAL,
	PRIMARY KEY (id_role, id_user),
	FOREIGN KEY (id_role) REFERENCES Roles(id_role),
	FOREIGN KEY (id_user) REFERENCES Utilisateur(id_user)
);

CREATE TABLE Adhésion(
	id_adhésion BIGSERIAL,
	id_user BIGSERIAL,
	date_expiration DATE,
	montant FLOAT NOT NULL,
	type_adhésion T_adhésion NOT NULL,
	PRIMARY KEY (id_adhésion)
);

CREATE TABLE Donateur(
	id_donateur BIGSERIAL,
	nom VARCHAR(30),
	prenom VARCHAR(30),
	PRIMARY KEY (id_donateur)
);

CREATE TABLE Donateur_utilisateur(
	id_donateur BIGSERIAL,
	id_user BIGSERIAL,
	PRIMARY KEY (id_donateur, id_user),
	FOREIGN KEY (id_donateur) REFERENCES Donateur(id_donateur),
	FOREIGN KEY (id_user) REFERENCES Utilisateur(id_user)
);

CREATE TABLE Don(
	id_don BIGSERIAL,
	date DATE NOT NULL,
	montant FLOAT NOT NULL,
	id_donateur BIGSERIAL,
	FOREIGN KEY(id_donateur) REFERENCES Donateur(id_donateur)
);

CREATE TABLE Fichier(
	id_fichier BIGSERIAL,
	chemin VARCHAR(255) NOT NULL,
	titre VARCHAR(50) NOT NULL,
	date_telechargement DATE NOT NULL,
	PRIMARY KEY (id_fichier)
);

CREATE TABLE PP(
	id_photo BIGSERIAL,
	id_user BIGSERIAL,
	PRIMARY KEY (id_photo, id_user),
	FOREIGN KEY (id_photo) REFERENCES Fichier(id_fichier),
	FOREIGN KEY (id_user) REFERENCES Utilisateur(id_user)
);

CREATE TABLE Groupe(
	id_groupe BIGSERIAL,
	titre VARCHAR(50),
	description VARCHAR(50),
	PRIMARY KEY (id_groupe)
);

CREATE TABLE Membre_groupe(
	id_groupe BIGSERIAL,
	id_user BIGSERIAL,
	PRIMARY KEY (id_groupe, id_user),
	FOREIGN KEY (id_groupe) REFERENCES Groupe(id_groupe),
	FOREIGN KEY (id_user) REFERENCES Utilisateur(id_user)
);

CREATE TABLE Fichier_groupe(
	id_photo BIGSERIAL,
	id_groupe BIGSERIAL,
	PRIMARY KEY (id_photo, id_groupe),
	FOREIGN KEY (id_groupe) REFERENCES Fichier(id_fichier),
	FOREIGN KEY (id_groupe) REFERENCES Groupe(id_groupe)
);

CREATE TABLE URL(
	id_url BIGSERIAL,
	url VARCHAR(255) NOT NULL,
	titre VARCHAR(50) NOT NULL,
	PRIMARY KEY (id_url)
);

CREATE TABLE URL_groupe(
	id_url BIGSERIAL,
	id_groupe BIGSERIAL,
	PRIMARY KEY (id_url, id_groupe),
	FOREIGN KEY (id_url) REFERENCES URL(id_url),
	FOREIGN KEY (id_groupe) REFERENCES Groupe(id_groupe)
);

CREATE TABLE Evt(
	id_evt BIGSERIAL,
	evt VARCHAR(50) NOT NULL,
	date VARCHAR(255) NOT NULL,
	PRIMARY KEY (id_evt)
);

CREATE TABLE Evt_groupe(
	id_evt BIGSERIAL,
	id_groupe BIGSERIAL,
	PRIMARY KEY(id_evt, id_groupe)
);

CREATE TABLE archive_utilisateur(
	id_user BIGSERIAL,
	nom VARCHAR(30) NOT NULL,
	prenom VARCHAR(30) NOT NULL,
	mdp VARCHAR(255) NOT NULL,
	vnom BOOL NOT NULL,
	vprenom BOOL NOT NULL,
	vphoto BOOL NOT NULL,
	date_inscription DATE NOT NULL,
	date_derniere_connexion DATE NOT NULL,
	adresse VARCHAR(60),
    email VARCHAR(20),
    phone VARCHAR(10),
    website VARCHAR(20),
	PRIMARY KEY (id_user)
);
CREATE TABLE archive_role_utilisateur(
	id_role BIGSERIAL,
	id_user BIGSERIAL,
	PRIMARY KEY (id_role, id_user),
	FOREIGN KEY (id_role) REFERENCES Roles(id_role),
	FOREIGN KEY (id_user) REFERENCES Utilisateur(id_user)
);
CREATE TABLE archive_adhésion(
	id_adhésion BIGSERIAL,
	id_user BIGSERIAL,
	date_expiration DATE,
	montant FLOAT NOT NULL,
	type_adhésion T_adhésion NOT NULL,
	PRIMARY KEY (id_adhésion)
);
CREATE TABLE archive_donateur(
	id_donateur BIGSERIAL,
	nom VARCHAR(30),
	prenom VARCHAR(30),
	PRIMARY KEY (id_donateur)
);
CREATE TABLE archive_donateur_utilisateur(
	id_donateur BIGSERIAL,
	id_user BIGSERIAL,
	PRIMARY KEY (id_donateur, id_user),
	FOREIGN KEY (id_donateur) REFERENCES Donateur(id_donateur),
	FOREIGN KEY (id_user) REFERENCES Utilisateur(id_user)
);
CREATE TABLE archive_don(
	id_don BIGSERIAL,
	date DATE NOT NULL,
	montant FLOAT NOT NULL,
	id_donateur BIGSERIAL,
	FOREIGN KEY(id_donateur) REFERENCES Donateur(id_donateur)
);

CREATE VIEW viewProfilUtilisateur AS
	SELECT info_user.id_user, info_user.nom, info_user.prenom, info_user.date_inscription, info_user.date_derniere_connexion, AD.type_adhésion, AD.date_expiration, info_user.chemin
	FROM 
		(SELECT U.id_user, U.nom, U.prenom, U.date_inscription, U.date_derniere_connexion, F.chemin
		FROM Utilisateur AS U, PP, Fichier AS F
		WHERE U.id_user = PP.id_user AND PP.id_photo = F.id_fichier) AS info_user
	LEFT JOIN Adhésion AS AD ON AD.id_user = info_user.id_user
	WHERE AD.date_expiration > CURRENT_TIMESTAMP
;

CREATE VIEW viewAdhérantsActuels AS
	SELECT U.id_user, U.nom, U.prenom, F.chemin
	FROM Utilisateur AS U, Adhésion AS AD, PP, Fichier F
	WHERE U.id_user = PP.id_user AND PP.id_photo = F.id_fichier AND U.id_user = AD.id_user AND AD.date_expiration > CURRENT_TIMESTAMP
;

CREATE VIEW viewExAdhérants AS
	SELECT user_info.id_user, user_info.nom, user_info.prenom, user_info.date, F.chemin
	FROM (SELECT U.id_user, U.nom, U.prenom, MAX(AD.date_expiration) AS date
		FROM Utilisateur AS U, Adhésion AS AD
		WHERE U.id_user = AD.id_user AND AD.date_expiration < CURRENT_TIMESTAMP
		GROUP BY U.id_user) AS user_info, PP, Fichier AS F
	WHERE user_info.id_user = PP.id_user AND PP.id_photo = F.id_fichier
;

CREATE VIEW viewAdhésionExpirant AS
	SELECT user_info.id_user, user_info.nom, user_info.prenom, F.chemin
	FROM (SELECT U.id_user, U.nom, U.prenom, (date_expiration - '1 month'::INTERVAL) AS limite
		 FROM Utilisateur AS U, Adhésion AS AD
		 WHERE U.id_user = AD.id_user) AS user_info, PP, Fichier AS F
	WHERE user_info.id_user = PP.id_user AND F.id_fichier = PP.id_photo AND  user_info.limite < CURRENT_TIMESTAMP
;

CREATE VIEW viewDonateursDons AS
	SELECT Donateur.nom AS donateur_nom, Donateur.prenom AS donateur_prenom, Utilisateur.nom, Utilisateur.prenom, Don.date, Don.montant
	FROM Donateur
		LEFT JOIN Donateur_utilisateur ON Donateur.id_donateur = Donateur_utilisateur.id_donateur
		LEFT JOIN Utilisateur ON Donateur_utilisateur.id_user = Utilisateur.id_user
		LEFT JOIN Don ON Donateur.id_donateur = Don.id_donateur
;

CREATE VIEW viewDonateursUtilisateurs AS
	SELECT Donateur.nom AS donateur_nom, Donateur.prenom AS donateur_prenom, Utilisateur.nom, Utilisateur.prenom
	FROM Donateur
	JOIN Donateur_utilisateur ON Donateur.id_donateur = Donateur_utilisateur.id_donateur
	JOIN Utilisateur ON Utilisateur.id_user = Donateur_utilisateur.id_user
;

CREATE VIEW viewHistoriqueAdhésion AS
	SELECT U.id_user, AD.date_expiration, AD.montant, AD.type_adhésion
	FROM Adhésion as AD
	JOIN Utilisateur as U ON U.id_user = AD.id_user
	WHERE AD.date_expiration < CURRENT_TIMESTAMP
;

CREATE VIEW viewMembreGroupe AS
	SELECT G.id_groupe, G.titre, U.id_user, U.nom, U.prenom, F.chemin
	FROM Groupe AS G, Membre_groupe AS MG, Utilisateur AS U, PP, Fichier AS F
	WHERE G.id_groupe = MG.id_groupe AND U.id_user = MG.id_user AND MG.id_user = PP.id_user AND PP.id_photo = F.id_fichier	
;

CREATE VIEW viewInfoGroupe AS
	SELECT G.id_groupe, G.titre AS nom_groupe, G.description, F.chemin, F.titre AS nom_image, URL.URL, URL.titre AS nom_url, E.evt, E.date
	FROM Groupe AS G, Fichier AS F, Fichier_groupe as FG, URL_groupe as UG, URL, Evt_groupe as EG, Evt AS E
	WHERE G.id_groupe = FG.id_groupe AND F.id_fichier = FG.id_photo AND G.id_groupe = UG.id_groupe AND URL.id_url = UG.id_url AND G.id_groupe = EG.id_groupe AND E.id_evt = EG.id_evt
;

-- Mêmes vues qu'en haut
--CREATE VIEW viewArchiveProfilUtilisateur;
--CREATE VIEW viewArchiveAdhésions;
--CREATE VIEW viewArchiveDons;
--CREATE VIEW viewArchiveDonateursDons;
--CREATE VIEW viewArchiveDonateursUtilisateurs;