CREATE SCHEMA IF NOT EXISTS na17p2;

SET
	search_path TO na17p2;

DROP TYPE IF EXISTS T_adhésion CASCADE;

DROP TABLE IF EXISTS Association CASCADE;

DROP TABLE IF EXISTS Fédération CASCADE;

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

DROP TABLE IF EXISTS "archive_donateur_info" CASCADE;

DROP TABLE IF EXISTS archive_donateur_utilisateur CASCADE;

DROP TABLE IF EXISTS archive_don CASCADE;

DROP VIEW IF EXISTS "viewProfilUtilisateur" CASCADE;

DROP VIEW IF EXISTS "viewFédération" CASCADE;

DROP VIEW IF EXISTS "viewAdherantsAsso" CASCADE;

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

CREATE TABLE Association(
	id_association BIGSERIAL,
	nom VARCHAR(30) NOT NULL,
	description TEXT NOT NULL,
	adresse VARCHAR(100) NOT NULL,
	telephone VARCHAR(10) NOT NULL,
	email VARCHAR(50) NOT NULL,
	date_creation DATE NOT NULL,
	PRIMARY KEY (id_association)
);

CREATE TABLE Fédération(
	id_federation BIGINT,
	id_association BIGINT,
	PRIMARY KEY (id_federation, id_association),
	FOREIGN KEY (id_federation) REFERENCES Association(id_association),
	FOREIGN KEY (id_association) REFERENCES Association(id_association),
	CHECK (id_federation <> id_association)
);

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
	id_role BIGINT,
	id_user BIGINT,
	PRIMARY KEY (id_role, id_user),
	FOREIGN KEY (id_role) REFERENCES Roles(id_role),
	FOREIGN KEY (id_user) REFERENCES Utilisateur(id_user)
);

CREATE TABLE Adhésion(
	id_adhésion BIGSERIAL,
	id_user BIGINT,
	date_expiration DATE,
	montant FLOAT NOT NULL,
	type_adhésion T_adhésion NOT NULL,
	id_association BIGINT,
	PRIMARY KEY (id_adhésion),
	FOREIGN KEY (id_user) REFERENCES Utilisateur(id_user),
	FOREIGN KEY (id_association) REFERENCES Association(id_association)
);

CREATE TABLE Donateur(
	id_donateur BIGSERIAL,
	PRIMARY KEY (id_donateur)
);

CREATE TABLE Donateur_info(
	id_donateur BIGINT,
	nom VARCHAR(30),
	prenom VARCHAR(30),
	PRIMARY KEY (id_donateur),
	FOREIGN KEY (id_donateur) REFERENCES Donateur(id_donateur)
);

CREATE TABLE Donateur_utilisateur(
	id_donateur BIGINT,
	id_user BIGINT UNIQUE,
	PRIMARY KEY (id_donateur, id_user),
	FOREIGN KEY (id_donateur) REFERENCES Donateur(id_donateur),
	FOREIGN KEY (id_user) REFERENCES Utilisateur(id_user)
);

CREATE TABLE Don(
	id_don BIGSERIAL,
	date DATE NOT NULL,
	montant FLOAT NOT NULL,
	id_donateur BIGINT,
	id_association BIGINT,
	FOREIGN KEY(id_donateur) REFERENCES Donateur(id_donateur),
	FOREIGN KEY(id_association) REFERENCES Association(id_association)
);

CREATE TABLE Fichier(
	id_fichier BIGSERIAL,
	chemin VARCHAR(255) NOT NULL,
	titre VARCHAR(50) NOT NULL,
	date_telechargement DATE NOT NULL,
	PRIMARY KEY (id_fichier)
);

CREATE TABLE PP(
	id_photo BIGINT,
	id_user BIGINT,
	PRIMARY KEY (id_photo, id_user),
	FOREIGN KEY (id_photo) REFERENCES Fichier(id_fichier),
	FOREIGN KEY (id_user) REFERENCES Utilisateur(id_user)
);

CREATE TABLE Groupe(
	id_groupe BIGSERIAL,
	infos JSON NOT NULL,
	fichiers JSON NOT NULL,
	urls JSON NOT NULL,
	evts JSON NOT NULL,
	PRIMARY KEY (id_groupe)
);

CREATE TABLE Membre_groupe(
	id_groupe BIGINT,
	id_user BIGINT,
	PRIMARY KEY (id_groupe, id_user),
	FOREIGN KEY (id_groupe) REFERENCES Groupe(id_groupe),
	FOREIGN KEY (id_user) REFERENCES Utilisateur(id_user)
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
	id_role BIGINT,
	id_user BIGINT,
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
	id_association BIGINT,
	PRIMARY KEY (id_adhésion),
	FOREIGN KEY (id_association) REFERENCES Association(id_association)
);

CREATE TABLE archive_donateur(
	id_donateur BIGSERIAL,
	PRIMARY KEY (id_donateur)
);

CREATE TABLE archive_donateur_info(
	id_donateur BIGINT,
	nom VARCHAR(30),
	prenom VARCHAR(30),
	PRIMARY KEY (id_donateur),
	FOREIGN KEY (id_donateur) REFERENCES archive_donateur(id_donateur)
);

CREATE TABLE archive_donateur_utilisateur(
	id_donateur BIGINT,
	id_user BIGINT,
	PRIMARY KEY (id_donateur, id_user),
	FOREIGN KEY (id_donateur) REFERENCES archive_donateur(id_donateur),
	FOREIGN KEY (id_user) REFERENCES archive_utilisateur(id_user)
);

CREATE TABLE archive_don(
	id_don BIGSERIAL,
	date DATE NOT NULL,
	montant FLOAT NOT NULL,
	id_donateur BIGINT,
	id_association BIGINT,
	FOREIGN KEY(id_donateur) REFERENCES archive_donateur(id_donateur),
	FOREIGN KEY(id_association) REFERENCES Association(id_association)
);

INSERT INTO
	Association(
		nom,
		description,
		adresse,
		telephone,
		email,
		date_creation
	)
VALUES
	(
		'Asso1',
		'Asso1',
		'123 rue bidon',
		'0102030405',
		'bidon1@bidon1.com',
		'2020-01-01 00:00:00'
	),
	(
		'Asso2',
		'Asso3',
		'231 rue bidon',
		'0202030405',
		'bidon2@bidon2.com',
		'2020-02-02 00:00:00'
	),
	(
		'Asso3',
		'Asso3',
		'312 rue bidon',
		'0302030405',
		'bidon3@bidon3.com',
		'2020-03-03 00:00:00'
	);

INSERT INTO
	Fédération(id_federation, id_association)
VALUES
	(1, 2),
	(1, 3);

INSERT INTO
	Utilisateur (
		id_user,
		nom,
		prenom,
		mdp,
		vnom,
		vprenom,
		vphoto,
		date_inscription,
		date_derniere_connexion,
		adresse,
		email,
		phone,
		website
	)
VALUES
	(
		1,
		'Martynka',
		'Isac',
		'lrPP0R0B0d',
		true,
		false,
		false,
		'2019-04-01 11:00:40',
		'2019-04-01 11:01:09',
		'86405 Dunning Circle',
		'imartynka0@google.fr',
		'6859983471',
		'http://google.com.au'
	),
	(
		2,
		'Boyle',
		'Margareta',
		'QfBLY4Pki',
		false,
		true,
		true,
		'2019-01-15 11:00:14',
		'2019-01-15 11:01:09',
		'56336 Brentwood Hill',
		'mboyle1@xing.com',
		'1582302686',
		'http://github.com'
	),
	(
		3,
		'Adrianello',
		'Laughton',
		'or7zUaY',
		true,
		false,
		true,
		'2019-11-30 15:00:00',
		'2019-11-30 15:01:09',
		'01 Lotheville Drive',
		'ladrianello2@epa.gov',
		'7185615301',
		'http://ucoz.com'
	),
	(
		4,
		'Szachniewicz',
		'Ruthann',
		'7KwBIF',
		true,
		false,
		false,
		'2018-12-02 17:00:36',
		'2018-12-02 17:01:09',
		'38575 Larry Court',
		'rszachniewicz3@mail.ru',
		'1346534269',
		'http://ifeng.com'
	),
	(
		5,
		'Haggus',
		'Ludvig',
		'iRRnO03',
		false,
		false,
		true,
		'2020-06-22 08:00:59',
		'2020-06-22 08:01:09',
		'918 Commercial Parkway',
		'lhaggus4@w3.org',
		'3355355321',
		'http://altervista.org'
	),
	(
		6,
		'Filde',
		'Crawford',
		'gyqgAUg2s',
		false,
		false,
		true,
		'2019-06-26 10:00:50',
		'2019-06-26 10:01:09',
		'5159 Beilfuss Trail',
		'cfilde5@freewebs.com',
		'1479679153',
		'http://plala.or.jp'
	),
	(
		7,
		'Peltz',
		'Cherey',
		'oACafCF',
		true,
		true,
		false,
		'2019-04-16 06:00:21',
		'2019-04-16 06:01:09',
		'55912 Scoville Park',
		'cpeltz6@jalbum.net',
		'5891009089',
		'http://google.cn'
	),
	(
		8,
		'Blazewicz',
		'Odella',
		'gKioQjOA',
		false,
		true,
		true,
		'2019-12-25 07:00:27',
		'2019-12-25 07:01:09',
		'30270 Schlimgen Trail',
		'oblazewicz7@ox.ac.uk',
		'1314665078',
		'https://gravatar.com'
	),
	(
		9,
		'Fitchew',
		'Feliks',
		'qIBwHzDHE',
		true,
		false,
		false,
		'2019-02-12 18:00:33',
		'2019-02-12 18:01:09',
		'9 Nevada Hill',
		'ffitchew8@abc.net.au',
		'7598379454',
		'http://dailymail.co.uk'
	),
	(
		10,
		'Chatain',
		'Dee',
		'TOnjX2sNzfNA',
		true,
		true,
		true,
		'2020-02-17 14:00:39',
		'2020-02-17 14:01:09',
		'1112 Main Trail',
		'dchatain9@nifty.com',
		'3286165899',
		'http://odnoklassniki.ru'
	);

INSERT INTO
	Roles (nom_role)
VALUES
	('Utilisateur'),
	('Administrateur');

INSERT INTO
	Role_utilisateur (id_role, id_user)
VALUES
	(2, 1),
	(1, 2),
	(1, 3),
	(1, 4),
	(1, 5),
	(1, 6),
	(1, 7),
	(1, 8),
	(1, 9),
	(1, 10);

INSERT INTO
	Adhésion (
		id_user,
		date_expiration,
		montant,
		type_adhésion,
		id_association
	)
VALUES
	(1, '2019-04-01 11:37:40', 40.0, 'Argent', 2),
	(2, '2019-01-15 11:01:14', 20.0, 'Bronze', 2),
	(3, '2019-11-30 15:54:00', 20.0, 'Bronze', 2),
	(4, '2018-12-02 17:27:36', 40.0, 'Argent', 2),
	(5, '2020-06-22 08:42:59', 20.0, 'Bronze', 2),
	(6, '2019-06-26 10:24:50', 40.0, 'Argent', 3),
	(7, '2019-04-16 06:12:21', 40.0, 'Argent', 3),
	(8, '2019-12-25 07:01:27', 60.0, 'Or', 3),
	(9, '2019-02-12 18:26:33', 20.0, 'Bronze', 3),
	(10, '2020-02-17 14:13:39', 40.0, 'Argent', 3);

INSERT INTO
	Donateur (id_donateur)
VALUES
	(1),
	(2),
	(3),
	(4);

INSERT INTO
	Donateur_info (id_donateur, nom, prenom)
VALUES
	(1, 'Jesus', 'Christ');

INSERT INTO
	Donateur_utilisateur(id_donateur, id_user)
VALUES
	(2, 1),
	(3, 2),
	(4, 3);

INSERT INTO
	Don(date, montant, id_donateur, id_association)
VALUES
	('2020-02-25 18:11:39', 95.4, 1, 1),
	('2019-08-29 01:18:45', 10.0, 2, 1),
	('2020-01-01 11:00:11', 100.0, 3, 1),
	('2018-04-05 23:09:45', 25.1, 4, 1);

INSERT INTO
	Fichier(id_fichier, chemin, titre, date_telechargement)
VALUES
	(
		1,
		'Martynka_Isac',
		'var/www/html/images/Martynka_Isac.jpeg',
		'2019-04-01 11:00:40'
	),
	(
		2,
		'Boyle_Margareta',
		'var/www/html/images/Boyle_Margareta.jpeg',
		'2019-01-15 11:00:14'
	),
	(
		3,
		'Adrianello_Laughton',
		'var/www/html/images/Adrianello_Laughton.jpeg',
		'2019-11-30 15:00:00'
	),
	(
		4,
		'Szachniewicz_Ruthann',
		'var/www/html/images/Szachniewicz_Ruthann.jpeg',
		'2018-12-02 17:00:36'
	),
	(
		5,
		'Haggus_Ludvig',
		'var/www/html/images/Haggus_Ludvig.jpeg',
		'2020-06-22 08:00:59'
	),
	(
		6,
		'Filde_Crawford',
		'var/www/html/images/Filde_Crawford.jpeg',
		'2019-06-26 10:00:50'
	),
	(
		7,
		'Peltz_Cherey',
		'var/www/html/images/Peltz_Cherey.jpeg',
		'2019-04-16 06:00:21'
	),
	(
		8,
		'Blazewicz_Odella',
		'var/www/html/images/Blazewicz_Odella.jpeg',
		'2019-12-25 07:00:27'
	),
	(
		9,
		'Fitchew_Feliks',
		'var/www/html/images/Fitchew_Feliks.jpeg',
		'2019-02-12 18:00:33'
	),
	(
		10,
		'Chatain_Dee',
		'var/www/html/images/Chatain_Dee.jpeg',
		'2020-02-17 14:00:39'
	),
	(
		11,
		'photo_SuperGroupe1',
		'/var/ww/html/images/foize.png',
		'2020-04-18 15:44:48'
	);

INSERT INTO
	PP(id_photo, id_user)
VALUES
	(1, 1),
	(2, 2),
	(3, 3),
	(4, 4),
	(5, 5),
	(6, 6),
	(7, 7),
	(8, 8),
	(9, 9),
	(10, 10);

INSERT INTO
	Groupe (id_groupe, infos, fichiers, urls, evts)
VALUES
	(
		1,
		'{"titre": "Super Groupe 1","description": "Description du groupe 1"}',
		'{"fichiers" : [1,2]}',
		'{"url" : [{ "id_url": 1,
                     "url": "librecours.net/",
                     "titre": "Libre Cours NA17"},
                   {"id_url": 2,
                    "url": "librecours.net/",
                    "titre": "Libre Cours NA17" }]}',
		'{"EVTs" : [{"id_evt": 1,
                     "evt": "Entretien individuel",
                     "date": "20200529T123000+0200"},
                    {"id_evt": 2,
                     "evt": "Entretien individuel",
                     "date": "20200529T123000+0200"}]}'
	);

INSERT INTO
	Membre_groupe (id_groupe, id_user)
VALUES
	(1, 1);

CREATE VIEW viewFédération AS
SELECT
	Fédération.id_federation,
	Fédération.id_association,
	Association.nom,
	Association.description,
	Association.adresse,
	Association.telephone,
	Association.email,
	Association.date_creation
FROM
	Fédération
	JOIN Association ON Fédération.id_association = Association.id_association;

CREATE VIEW viewProfilUtilisateur AS
SELECT
	info_user.id_user,
	info_user.nom,
	info_user.prenom,
	info_user.date_inscription,
	info_user.date_derniere_connexion,
	AD.type_adhésion,
	AD.date_expiration,
	info_user.chemin
FROM
	(
		SELECT
			U.id_user,
			U.nom,
			U.prenom,
			U.date_inscription,
			U.date_derniere_connexion,
			F.chemin
		FROM
			Utilisateur AS U,
			PP,
			Fichier AS F
		WHERE
			U.id_user = PP.id_user
			AND PP.id_photo = F.id_fichier
	) AS info_user
	LEFT JOIN Adhésion AS AD ON AD.id_user = info_user.id_user
WHERE
	AD.date_expiration > CURRENT_TIMESTAMP;

CREATE VIEW viewAdherantsAsso AS
SELECT
	Association.id_association,
	Adhésion.date_expiration,
	Adhésion.type_adhésion,
	Utilisateur.id_user,
	Utilisateur.nom,
	Utilisateur.prenom,
	Utilisateur.date_inscription,
	Utilisateur.date_derniere_connexion,
	Utilisateur.adresse,
	Utilisateur.email,
	Utilisateur.phone,
	Utilisateur.website,
	Fichier.chemin
FROM
	Association
	JOIN Adhésion ON Association.id_association = Adhésion.id_association
	JOIN Utilisateur ON Adhésion.id_user = Utilisateur.id_user
	JOIN PP ON PP.id_user = Adhésion.id_user
	JOIN Fichier ON PP.id_photo = Fichier.id_fichier;

CREATE VIEW viewAdhérantsActuels AS
SELECT
	U.id_user,
	U.nom,
	U.prenom,
	F.chemin
FROM
	Utilisateur AS U,
	Adhésion AS AD,
	PP,
	Fichier F
WHERE
	U.id_user = PP.id_user
	AND PP.id_photo = F.id_fichier
	AND U.id_user = AD.id_user
	AND AD.date_expiration > CURRENT_TIMESTAMP;

CREATE VIEW viewExAdhérants AS
SELECT
	user_info.id_user,
	user_info.nom,
	user_info.prenom,
	user_info.date,
	F.chemin
FROM
	(
		SELECT
			U.id_user,
			U.nom,
			U.prenom,
			MAX(AD.date_expiration) AS date
		FROM
			Utilisateur AS U,
			Adhésion AS AD
		WHERE
			U.id_user = AD.id_user
			AND AD.date_expiration < CURRENT_TIMESTAMP
		GROUP BY
			U.id_user
	) AS user_info,
	PP,
	Fichier AS F
WHERE
	user_info.id_user = PP.id_user
	AND PP.id_photo = F.id_fichier;

CREATE VIEW viewAdhésionExpirant AS
SELECT
	user_info.id_user,
	user_info.nom,
	user_info.prenom,
	F.chemin
FROM
	(
		SELECT
			U.id_user,
			U.nom,
			U.prenom,
			(date_expiration - '1 month' :: INTERVAL) AS limite
		FROM
			Utilisateur AS U,
			Adhésion AS AD
		WHERE
			U.id_user = AD.id_user
	) AS user_info,
	PP,
	Fichier AS F
WHERE
	user_info.id_user = PP.id_user
	AND F.id_fichier = PP.id_photo
	AND user_info.limite < CURRENT_TIMESTAMP;

CREATE VIEW viewDonateursDons AS
SELECT
	Donateur_info.nom AS donateur_nom,
	Donateur_info.prenom AS donateur_prenom,
	Utilisateur.nom,
	Utilisateur.prenom,
	Don.date,
	Don.montant
FROM
	Donateur
	LEFT JOIN Donateur_utilisateur ON Donateur.id_donateur = Donateur_utilisateur.id_donateur
	LEFT JOIN Donateur_info ON Donateur.id_donateur = Donateur_info.id_donateur
	LEFT JOIN Utilisateur ON Donateur_utilisateur.id_user = Utilisateur.id_user
	LEFT JOIN Don ON Donateur.id_donateur = Don.id_donateur;

CREATE VIEW viewDonateursUtilisateurs AS
SELECT
	Donateur_info.nom AS donateur_nom,
	Donateur_info.prenom AS donateur_prenom,
	Utilisateur.nom,
	Utilisateur.prenom
FROM
	Donateur
	JOIN Donateur_utilisateur ON Donateur.id_donateur = Donateur_utilisateur.id_donateur
	JOIN Donateur_info ON Donateur.id_donateur = Donateur_info.id_donateur
	JOIN Utilisateur ON Utilisateur.id_user = Donateur_utilisateur.id_user;

CREATE VIEW viewHistoriqueAdhésion AS
SELECT
	U.id_user,
	AD.date_expiration,
	AD.montant,
	AD.type_adhésion
FROM
	Adhésion as AD
	JOIN Utilisateur as U ON U.id_user = AD.id_user
WHERE
	AD.date_expiration < CURRENT_TIMESTAMP;

CREATE VIEW viewMembreGroupe AS
SELECT
	G.id_groupe,
	G.infos ->> 'titre' AS titre_groupe,
	G.infos ->> 'description' AS description_groupe,
	U.id_user,
	U.nom,
	U.prenom,
	F.chemin
FROM
	Groupe AS G,
	Membre_groupe AS MG,
	Utilisateur AS U,
	PP,
	Fichier AS F
WHERE
	G.id_groupe = MG.id_groupe
	AND U.id_user = MG.id_user
	AND MG.id_user = PP.id_user
	AND PP.id_photo = F.id_fichier;

CREATE VIEW viewURLGroupe AS
SELECT
	G.id_groupe,
	G.infos ->> 'titre' AS titre_groupe,
	G.infos ->> 'description' AS description_groupe,
	url ->> 'id_url' AS id_url,
	url ->> 'url' AS url,
	url ->> 'titre' AS titre_url
FROM
	Groupe AS G
	CROSS JOIN json_array_elements(G.urls -> 'url') AS url;

CREATE VIEW viewEvtGroupe AS
SELECT
	G.id_groupe,
	G.infos ->> 'titre' AS titre_groupe,
	G.infos ->> 'description' AS description_groupe,
	evt ->> 'id_evt' AS id_evt,
	evt ->> 'evt' AS evt,
	evt ->> 'date' AS date_evt
FROM
	Groupe AS G
	CROSS JOIN json_array_elements(G.evts -> 'EVTs') AS evt;

CREATE VIEW viewFichierGroupe AS
SELECT
	G.id_groupe,
	G.infos ->> 'titre' AS titre_groupe,
	G.infos ->> 'description' AS description_groupe,
	id_fichier :: TEXT :: BIGINT AS id_fichier_1,
	Fichier.chemin,
	Fichier.titre,
	Fichier.date_telechargement
FROM
	(
		SELECT
			*
		FROM
			Groupe AS G
			CROSS JOIN json_array_elements(G.fichiers -> 'fichiers') AS id_fichier
	) AS G
	JOIN Fichier ON G.value :: TEXT :: BIGINT = Fichier.id_fichier;

-- Les données de tests en archive sont identiques.
-- Mêmes vues qu'en haut
--CREATE VIEW viewArchiveProfilUtilisateur;
--CREATE VIEW viewArchiveAdhésions;
--CREATE VIEW viewArchiveDons;
--CREATE VIEW viewArchiveDonateursDons;
--CREATE VIEW viewArchiveDonateursUtilisateurs;