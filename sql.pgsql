CREATE SCHEMA IF NOT EXISTS na17p2;
SET search_path TO na17p2;

DROP TYPE IF EXISTS T_adhésion CASCADE;
DROP TABLE IF EXISTS Roles CASCADE;
DROP TABLE IF EXISTS Utilisateur CASCADE;
DROP TABLE IF EXISTS Role_utilisateur CASCADE;
DROP TABLE IF EXISTS Adhésion CASCADE;
DROP TABLE IF EXISTS Donateur CASCADE;
DROP TABLE IF EXISTS Donateur_info CASCADE;
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
DROP VIEW IF EXISTS "viewProfilUtilisateur" CASCADE;
DROP VIEW IF EXISTS "viewAdhérantsActuels" CASCADE;
DROP VIEW IF EXISTS "viewExAdhérants" CASCADE;
DROP VIEW IF EXISTS "viewAdhésionExpirant" CASCADE;
DROP VIEW IF EXISTS "viewHistoriqueAdhésion" CASCADE;
DROP VIEW IF EXISTS "viewMembreGroupe" CASCADE;
DROP VIEW IF EXISTS "viewInfoGroupe" CASCADE;
DROP VIEW IF EXISTS "viewDonateursDons" CASCADE;
DROP VIEW IF EXISTS "viewDonateursUtilisateurs" CASCADE;
DROP VIEW IF EXISTS "viewArchiveProfilUtilisateur" CASCADE;
DROP VIEW IF EXISTS "viewArchiveAdhésions" CASCADE;
DROP VIEW IF EXISTS "viewArchiveDons" CASCADE;
DROP VIEW IF EXISTS "viewArchiveDonateursDons" CASCADE;
DROP VIEW IF EXISTS "viewArchiveDonateursUtilisateurs" CASCADE;

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
    email VARCHAR(100),
    phone VARCHAR(10),
    website VARCHAR(100),
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
	PRIMARY KEY (id_donateur)
);

CREATE TABLE Donateur_info(
	id_donateur BIGSERIAL,
	nom VARCHAR(30),
	prenom VARCHAR(30),
	PRIMARY KEY (id_donateur),
	FOREIGN KEY (id_donateur) REFERENCES Donateur(id_donateur)
);

CREATE TABLE Donateur_utilisateur(
	id_donateur BIGSERIAL,
	id_user BIGSERIAL UNIQUE,
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
	SELECT Donateur_info.nom AS donateur_nom, Donateur_info.prenom AS donateur_prenom, Utilisateur.nom, Utilisateur.prenom, Don.date, Don.montant
	FROM Donateur
		LEFT JOIN Donateur_utilisateur ON Donateur.id_donateur = Donateur_utilisateur.id_donateur
		LEFT JOIN Donateur_info ON Donateur.id_donateur = Donateur_info.id_donateur
		LEFT JOIN Utilisateur ON Donateur_utilisateur.id_user = Utilisateur.id_user
		LEFT JOIN Don ON Donateur.id_donateur = Don.id_donateur
;

CREATE VIEW viewDonateursUtilisateurs AS
	SELECT Donateur_info.nom AS donateur_nom, Donateur_info.prenom AS donateur_prenom, Utilisateur.nom, Utilisateur.prenom
	FROM Donateur
	JOIN Donateur_utilisateur ON Donateur.id_donateur = Donateur_utilisateur.id_donateur
	JOIN Donateur_info ON Donateur.id_donateur = Donateur_info.id_donateur
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


INSERT INTO Utilisateur (id_user, nom, prenom, mdp, vnom, vprenom, vphoto, date_inscription, date_derniere_connexion, adresse, email, phone, website)
VALUES 
(1, 'Martynka', 'Isac', 'lrPP0R0B0d', true, false, false, '2019-04-01 11:00:40', '2019-04-01 11:01:09', '86405 Dunning Circle', 'imartynka0@google.fr', '6859983471', 'http://google.com.au'),
(2, 'Boyle', 'Margareta', 'QfBLY4Pki', false, true, true, '2019-01-15 11:00:14', '2019-01-15 11:01:09', '56336 Brentwood Hill', 'mboyle1@xing.com', '1582302686', 'http://github.com'),
(3, 'Adrianello', 'Laughton', 'or7zUaY', true, false, true, '2019-11-30 15:00:00', '2019-11-30 15:01:09', '01 Lotheville Drive', 'ladrianello2@epa.gov', '7185615301', 'http://ucoz.com'),
(4, 'Szachniewicz', 'Ruthann', '7KwBIF', true, false, false, '2018-12-02 17:00:36', '2018-12-02 17:01:09', '38575 Larry Court', 'rszachniewicz3@mail.ru', '1346534269', 'http://ifeng.com'),
(5, 'Haggus', 'Ludvig', 'iRRnO03', false, false, true, '2020-06-22 08:00:59', '2020-06-22 08:01:09', '918 Commercial Parkway', 'lhaggus4@w3.org', '3355355321', 'http://altervista.org'),
(6, 'Filde', 'Crawford', 'gyqgAUg2s', false, false, true, '2019-06-26 10:00:50', '2019-06-26 10:01:09', '5159 Beilfuss Trail', 'cfilde5@freewebs.com', '1479679153', 'http://plala.or.jp'),
(7, 'Peltz', 'Cherey', 'oACafCF', true, true, false, '2019-04-16 06:00:21', '2019-04-16 06:01:09', '55912 Scoville Park', 'cpeltz6@jalbum.net', '5891009089', 'http://google.cn'),
(8, 'Blazewicz', 'Odella', 'gKioQjOA', false, true, true, '2019-12-25 07:00:27', '2019-12-25 07:01:09', '30270 Schlimgen Trail', 'oblazewicz7@ox.ac.uk', '1314665078', 'https://gravatar.com'),
(9, 'Fitchew', 'Feliks', 'qIBwHzDHE', true, false, false, '2019-02-12 18:00:33', '2019-02-12 18:01:09', '9 Nevada Hill', 'ffitchew8@abc.net.au', '7598379454', 'http://dailymail.co.uk'),
(10, 'Chatain', 'Dee', 'TOnjX2sNzfNA', true, true, true, '2020-02-17 14:00:39', '2020-02-17 14:01:09', '1112 Main Trail', 'dchatain9@nifty.com', '3286165899', 'http://odnoklassniki.ru');

INSERT INTO Roles (nom_role)
VALUES ('Utilisateur'), ('Administrateur');

INSERT INTO Role_utilisateur (id_role, id_user)
VALUES (2, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (1, 8), (1, 9), (1, 10);

INSERT INTO Adhésion (id_user, date_expiration, montant, type_adhésion)
VALUES 
(1, '2019-04-01 11:37:40', 40.0, 'Argent'),
(2, '2019-01-15 11:01:14',  20.0, 'Bronze'),
(3, '2019-11-30 15:54:00', 20.0, 'Bronze'),
(4, '2018-12-02 17:27:36',  40.0, 'Argent'),
(5, '2020-06-22 08:42:59',  20.0, 'Bronze'),
(6, '2019-06-26 10:24:50',  40.0, 'Argent'),
(7, '2019-04-16 06:12:21',  40.0, 'Argent'),
(8, '2019-12-25 07:01:27',  60.0, 'Or'),
(9, '2019-02-12 18:26:33', 20.0, 'Bronze'),
(10, '2020-02-17 14:13:39',  40.0, 'Argent');

INSERT INTO Donateur (id_donateur)
VALUES (1), (2), (3), (4);

INSERT INTO Donateur_info (id_donateur, nom, prenom)
VALUES (1, 'Jesus', 'Christ');

INSERT INTO Donateur_utilisateur(id_donateur, id_user)
VALUES (2, 1), (3, 2), (4, 3);

INSERT INTO Don(date, montant, id_donateur)
VALUES ('2020-02-25 18:11:39', 95.4, 1), ('2019-08-29 01:18:45', 10.0, 2), ('2020-01-01 11:00:11', 100.0, 3), ('2018-04-05 23:09:45', 25.1, 4);

INSERT INTO Fichier(id_fichier, chemin, titre, date_telechargement)
VALUES 
(1, 'Martynka_Isac', 'var/www/html/images/Martynka_Isac.jpeg', '2019-04-01 11:00:40'),
(2, 'Boyle_Margareta', 'var/www/html/images/Boyle_Margareta.jpeg', '2019-01-15 11:00:14'),
(3, 'Adrianello_Laughton', 'var/www/html/images/Adrianello_Laughton.jpeg', '2019-11-30 15:00:00'),
(4, 'Szachniewicz_Ruthann', 'var/www/html/images/Szachniewicz_Ruthann.jpeg', '2018-12-02 17:00:36'),
(5, 'Haggus_Ludvig', 'var/www/html/images/Haggus_Ludvig.jpeg', '2020-06-22 08:00:59'),
(6, 'Filde_Crawford', 'var/www/html/images/Filde_Crawford.jpeg', '2019-06-26 10:00:50'),
(7, 'Peltz_Cherey', 'var/www/html/images/Peltz_Cherey.jpeg', '2019-04-16 06:00:21'),
(8, 'Blazewicz_Odella', 'var/www/html/images/Blazewicz_Odella.jpeg', '2019-12-25 07:00:27'),
(9, 'Fitchew_Feliks', 'var/www/html/images/Fitchew_Feliks.jpeg', '2019-02-12 18:00:33'),
(10, 'Chatain_Dee', 'var/www/html/images/Chatain_Dee.jpeg', '2020-02-17 14:00:39'),
(11, 'photo_SuperGroupe1', '/var/ww/html/images/foize.png', '2020-04-18 15:44:48');

INSERT INTO PP(id_photo, id_user)
VALUES (1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

INSERT INTO Groupe (id_groupe, titre, description)
VALUES ('1', 'Super Groupe 1', 'Description du groupe 1');

INSERT INTO Membre_groupe (id_groupe, id_user)
VALUES (1, 1);

INSERT INTO Fichier_groupe(id_photo, id_groupe)
VALUES (11, 1);

INSERT INTO URL(id_url, url, titre)
VALUES (1, 'librecours.net/', 'Libre Cours NA17');

INSERT INTO URL_groupe(id_url, id_groupe)
VALUES (1 ,1);

INSERT INTO Evt(id_evt, evt, date)
VALUES (1, 'Entretien individuel', '20200529T123000+0200');

INSERT INTO Evt_groupe(id_evt, id_groupe)
VALUES (1, 1);

-- Les données de tests en archive sont identiques.
-- Mêmes vues qu'en haut
--CREATE VIEW viewArchiveProfilUtilisateur;
--CREATE VIEW viewArchiveAdhésions;
--CREATE VIEW viewArchiveDons;
--CREATE VIEW viewArchiveDonateursDons;
--CREATE VIEW viewArchiveDonateursUtilisateurs;