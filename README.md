# na17p2
Quach Pascal

Sujet 1 : Adhésion : Outil de gestion des adhérents d'une association

# Adhésion : Outil de gestion des adhérents d'une association
## Recueil des besoins

L'objectif de l'application est de permettre une gestion des adhérents d'une petite association.

L'application permet à chaque personne de renseigner ses coordonnées personnelles. Elle aura le choix d'accepter ou non de publier son nom, son prénom et sa photo sur le site de l'association.

Les administrateurs peuvent gérer les adhésions, c'est à dire indiquer qui est adhérent (jusqu'à une certaine date) et quel montant d'adhésion a été versé ; il peuvent aussi superviser les dates d'adhésion de chaque personne (et notamment avoir la liste des adhésions qui se terminent bientôt). Il existe plusieurs types d'adhésion, dépendant des associations, par exemple bronze, or et argent, ou normale ou honoraire, ou encore étudiant, en activité, etc. Les administrateurs gèrent cette typologie. Les administrateurs peuvent également gérer les donateurs et les dons (un donateur n'est pas forcément un adhérent, ni un adhérent un donateur).

Les administrateurs peuvent créer des groupes et assigner les personnes à des groupes. Les personnes d'un groupe peuvent ajouter des informations à ce groupe : date d'un événement (avec export au format vCal), URL d'un outil web utilisé par le groupe (chaque URL est associée à un titre), informations générales (composées d'un titre, d'un texte), photos (composées d'un titre et d'un fichier), etc. Chaque groupe dispose d'une page web exposant les informations associées à ce groupe.

Les informations concernant les groupes sont périssables (elle peuvent être définitivement supprimées). En revanche les informations concernant les adhésions et les adhérents doivent pouvoir être archivées (c'est à dire conserver dans un espace de la base de données qui n'est plus accessible via l'application principale).

## Exemple d'interfaces de l'application
- page de connexion
- page d'inscription
- page pour modifier ses coordonnées (nom, prénom, mail, mobile, adresse... certains champs sont facultatifs)
- page d'administration permettant de voir tous les gens inscrits sur le site, les personnes adhérentes, les informations pour chaque personne, les personnes dont l'adhésion a expiré, les cotisations qui vont expirer dans le mois qui vient, etc.
- page d'administration permettant de saisir les adhésions et dons
- page d'administration permettant de gérer les groupes
- page d'accès aux archives
- page d'export permettant aux administrateurs d'exporter la liste des adhérents dans un format CSV ou un format vCard.

# Webapp exemple 
Un exemple Next.js de communication avec une BDD PGSQL à l'aide de [Supabase](https://supabase.io/docs/about) 

L'exemple utilisé provient de https://github.com/supabase/realtime/tree/master/examples/next-js.
L'exemple a été adapté au projet en partie.

Dépendances :
- Docker : il faut activer le partage de fichier (*file sharing*) dans le dossier où on lance `docker-compose`.
- npm (Node.js)
Etapes d'installation :
1. `npm install`: installation des dépendances node
2.  `npm run build`: pour compiler l'app
3.  `docker-compose up` : démarrage du serveur en local au port 4000. *Attention, téléchargement lourd ! ~2Go*.
4.  `npm start` : démarrage du serveur web au port 3000
5.  http://localhost:3000 : la "webapp"

