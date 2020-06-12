- [Avant-propos](#avant-propos)
- [Note de clarification](#note-de-clarification)
  - [Objectif de l'application](#objectif-de-lapplication)
  - [Utilisateur](#utilisateur)
    - [Adhésion](#adhésion)
      - [Adhérent](#adhérent)
      - [Type d'adhésion](#type-dadhésion)
    - [Dons](#dons)
      - [Donateur](#donateur)
    - [Remarques sur l'association Utilisateur - Donateur](#remarques-sur-lassociation-utilisateur---donateur)
  - [Groupe](#groupe)
    - [Page web](#page-web)
    - [Informations générales](#informations-générales)
      - [Date d'un évènement](#date-dun-évènement)
      - [Outil (URL + Titre)](#outil-url--titre)
      - [Photos (Titre + fichier)](#photos-titre--fichier)
      - [Autres](#autres)
  - [Fédérations](#fédérations)
    - [Association](#association)
    - [Fédération](#fédération)
  - [Accès aux fonctionnalités](#accès-aux-fonctionnalités)
    - [Accès utilisateur](#accès-utilisateur)
    - [Accès adhérent](#accès-adhérent)
    - [Accès administrateur](#accès-administrateur)
  - [Gestion des données](#gestion-des-données)
    - [Fichiers binaires (photos)](#fichiers-binaires-photos)
    - [Utilisateur](#utilisateur-1)
    - [Groupe](#groupe-1)
  - [Exemples d'interfaces de l'application](#exemples-dinterfaces-de-lapplication)
    - [Page de connexion](#page-de-connexion)
    - [Page d'inscription](#page-dinscription)
    - [Page profil utilisateur](#page-profil-utilisateur)
    - [Page d'administration de l'association](#page-dadministration-de-lassociation)
    - [Page d'administration de saisie des adhérants et des dons](#page-dadministration-de-saisie-des-adhérants-et-des-dons)
    - [Page d'administration des groupes](#page-dadministration-des-groupes)
    - [Page d'accès aux archives](#page-daccès-aux-archives)
    - [Page d'export](#page-dexport)

# Avant-propos

On utilise le lien de dépendance. Voir explications. 
[UML/SysML](https://www.uml-sysml.org/documentation/uml-2.1.2-superstructure-5.8mo/at_download/OMG%20Unified%20Modeling%20Language%202.1.2_Superstructure_November2007.pdf#G6.1158534)
[Developpez.com](https://laurent-audibert.developpez.com/Cours-UML/?page=diagramme-classes#L3-3-10)

# Note de clarification
## Objectif de l'application
> L'objectif de l'application est de permettre une gestion des adhérents d'une petite association.
Le service de l'application se centralise autour de la gestion des adhérents de fédérations. On distinguera les fonctionnalités accessibles aux utilisateurs, aux utilisateurs adhérents et aux utilisateurs administrateurs. 

## Utilisateur
Un utilisateur de l'application aura l'obligation de se créer un compte pour accéder aux services de l'application. Ainsi, il possèdera un **nom d'utilisateur** et un **mot de passe**. Ce dernier ne sera stocké que dans sa version encrypté avec un sel. On se munira d'une fonction de dérivation de clé pour encrypter le mot de passe, pour permettre l'étirement de la clé.

L'utilisateur aura l'obligation de renseigner son **nom** et son **prénom**. 

L'utilisateur peut éventuellement s'il le veut renseigner ses coordonnées personnelles (**adresse postale**, **email**, **téléphone**, **site web personnel**). 

L'utilisateur peut éventuellement télécharger *une* **photo** sur son profil. La photo sera stockée avec pour titre "[nom]_[prenom]".

L'utilisateur a l'obligation de choisir de **publier son nom, son prénom et sa photo**, c'est-à-dire qu'il fera un choix invidivuel pour chaque information. La publication de son information rendra accessible l'information en question sur le site de l'association. 

### Adhésion
L'adhésion d'un utilisateur est valide jusqu'à une certaine **date** incluse, après laquelle l'adhésion n'est plus valide, s'il a réglé versé la **cotisation** du type de son adhésion.

L'adhésion s'adresse à une association. 

#### Adhérent
Un utilisateur dont l'adhésion est valide sera considéré comme un adhérent.

La publication de l'identité de l'adhérent avec sa photo utilisateur s'il en a une sur le site de l'association se fera sous la dénomination d'un adhérent, contrairement aux utilisateurs qui apparaitront dans une catégorie à part.

#### Type d'adhésion
Les administrateurs de l'association pourront définir plusieurs **types d'adhésion**. Par exemple : bronze < argent < or, ou normale < honoraire, ou étudiant(e)/en activité/retraité(e). 

Les montants, les types d'adhésion, la périodicité et les motifs de remboursement sont relatifs aux statuts de l'association. Pour cette raison, les administrateurs de l'association ont la liberté de modifier la **typologie** directement dans l'application. 

Cette liberté de modification pose un soucis dans le schéma du gestionnaire de base de données. Si on considère que la typologie est modélisée par un enum, que se passe-t-il lorsqu'on doit le modifier ? Cette modification représente un danger pour les informations stockés dans la table.

On imagine plusieurs scénarions : 
1. Ajout d'un type d'adhésion : la modification n'affecte en rien les autres types d'adhésion, et on modifie simplement les valeurs possibles de l'enum.
2. La suppression d'un type d'adhésion : elle est en pratique impossible sans complexifier inutilement le schéma. On ne peut que "ignorer" la valeur. On imagine restreindre les insertions aux valeurs de l'enum SAUF ces valeurs "supprimées". De préférence, on implémenterait cela du côté applicatif, en éliminant tout simplement les types d'adhésions supprimées. Il serait alors en théorie "impossible" d'insérer une adhésion avec ce type là.

### Dons
La donation est un service fourni par l'application. Les donations via l'application ne pourront donc être accessibles qu'aux utilisateurs de l'application, c'est-à-dire ceux qui auront créé un compte utilisateur. 

Les éventuelles réductions d'impôts associés aux dons à l'association sont contraintes à l'éligibilité de l'association comme définis aux articles 200 et 238 bis du code général des impôts. Plus précisément, l'association doit avoir été reconnu d'utilité publique ou autre condition d'éligibilité. 

Le don s'adresse à une association en particulier. Une association reçoit autant de dons qu'elle le souhaite.

#### Donateur
Un utilisateur dont la donation aura été comptabilisé sera considéré comme un donateur. Un utilisateur n'est évidemment pas sous contrainte d'effectuer un don. 

Un don seul, non associé à un utilisateur, peut être comptabilisé par un administrateur de l'application uniquement, car le donateur n'aurait pas de compte utilisateur. 

Ainsi, un donateur n'est pas forcément un utilisateur, ni un utilisateur forcément un donateur. Si un utilisateur a effectué un don, il sera considéré également comme un donateur.
Si un donateur venait à se créer un compte utilisateur, on s'efforcera de l'associer à sa ou ses donations. 

### Remarques sur l'association Utilisateur - Donateur

1. Un utilisateur n'est pas obligatoirement un donateur : Utilisateur - "0...*" Donateur
2. Un utilisateur, s'il est donateur, n'apparaît qu'une fois : Utilisateur - "0..1" Donateur
3. Un donateur n'est pas obligatoirement un utilisateur : Utilisateur "0...*" - Donateur
4. Un donateur, s'il est utilisateur, n'apparaît qu'une fois : Utilisateur "0...1" - Donateur
5. Donc : Utilisateur "0...1" - "0...1" Donateur

On pourrait modéliser cette association par un double héritage "donateur-utilisateur". Le choix est fait de ne pas choisir cette option, pour ne pas complexifier le modèle. Il n'y a pas non plus grand intérêt à faire explicitement apparaître les entités à la fois donateur et utilisateur. Elles ne sont aucunement spéciales dans le schéma. 

## Groupe
Les utilisateurs peuvent constituer un groupe. Un groupe est constitué au minimum d'un utilisateur. Le groupe peut accueillir des utilisateurs sans limite, à la condition que l'utilisateur n'apparaisse qu'une fois par groupe. 

Les informations du groupe sont par défaut vides. 

Si un groupe n'a plus de membres adhérants, une limite de temps leur est fixée avant que le groupe ne soit supprimé.

Un groupe est indépendant des associations ou des fédérations.

### Page web
Le groupe possède obligatoirement **une** page web exposant toutes les informations associées au groupe.

### Informations générales
Le groupe possède éventuellement **un titre**, et **une description**.

#### Date d'un évènement
Un groupe pourra ajouter à ses informations la **date d'un évènement**, qui sera également associée à un titre pour soucis de préservation de l'information. Une date seule est rarement utile.

Cette date pourra être exportée au '[format vCal](https://web.archive.org/web/20000816001520/http://www.imc.org/pdi/vcal-10.txt)', qui reprend les spécifications de la norme [ISO 8601](https://fr.wikipedia.org/wiki/ISO_8601) pour la représentation des dates et horaires. 

Les utilisateurs du groupe peuvent rajouter plusieurs dates sans limite.

#### Outil (URL + Titre)
Le groupe peut partager le lien d'un **outil collaboratif** (ou outil web utilisé par le groupe par exemple), qui sera composé d'une URL et d'un titre.

Les utilisateurs du groupe peut partager plusieurs outils sans limite.

#### Photos (Titre + fichier)
Les utilisateurs du groupe ont le droit de partager du contenu tels que des **photos, ou autres**. Ces contenus seront associés à un **titre**.

Les utilisateurs du groupe peuvent partager plusieurs photos sans limite.

#### Autres
Les groupes pourront évoluer au fur et à mesure du développement de l'application. On pourrait ajouter d'autres informations tels que la localisation d'un tel groupe, etc.

## Fédérations

### Association
Une association est une entité est un groupement de personnes volontaires réunies autour d’un projet commun ou partageant des activités [3](https://www.vie-publique.fr/fiches/24076-quest-ce-quune-association).

Dans le cadre de ce projet, on gèrera une multitude d'associations dont pourront faire parti les utilisateurs. 

L'utilisateur n'a pas de limite concernant le nombre d'associations auxquelles il peut appartenir. Une association n'a pas non plus de limite de membres. 

Une association aura un nom, une description, une adresse, un téléphone, un email, et une date de création obligatoirement.

### Fédération
Une fédération est une association qui regroupe plusieurs associations. 

## Accès aux fonctionnalités
### Accès utilisateur
L'utilisateur aura accès à son profil utilisateur, et pourra modifier ses coordonnées. 

On notera bien qu'un utilisateur n'est pas forcément un adhérent (son adhésion peut avoir expiré), mais il aura néanmoins la possibilité d'effectuer un don s'il le souhaite. 

Il aura également le droit d'accéder aux archives le concernant. 

Les droits de l'utilisateur sont en corcordance avec le RGPD. Il aura donc par exemple le droit de supprimer son compte s'il le souhaite. 

### Accès adhérent
L'adhérent est un utilisateur qui aura vu son adhésion validé. Il a ainsi accès à tous les droits de l'utilisateur.

Les adhérents ont accès aux actualités internes de l'association, qui ne sont pas destinés au public. 

Les adhérents s'ils font parmi d'un groupe, peuvent modifier les informations du dit groupe. Si un adhérant fait partie d'un groupe mais que son adhésion expire, il n'aura plus accès aux informations du groupe, mais restera membre du groupe. Dès que son adhésion redevient valide, il aura accès de nouveau aux informations du groupe.

Les adhérents ne peuvent pas créer de groupe, et peuvent appartenir à des groupes sans limite. 

### Accès administrateur
Toutes les informations relatives à l'adhésion d'un utilisateur seront gérés par les administrateurs de l'application. 

Toutes les informations relatives aux donateurs de l'association et aux dons à l'association seront gérés par les administrateurs de l'application. 

Les administrateurs gèrent la création et la suppression de groupes. Ils gèrent également la gestion des membres d'un groupe.

Les administrateurs gèrent la création et la suppression des associations, ainsi que des fédérations. Ils gèrent la gestion des associations d'une fédération. 

## Gestion des données

### Fichiers binaires (photos)
Les fichiers binaires tels que les photos seront stockés sur le serveur compressés, et on stockera dans la base de données le chemin vers le fichier. 

### Utilisateur
Les données des utilisateurs seront archivées, données adhérents compris évidemment. 
Lors de l'implémentation, on pourra dédoubler les tables par archive_utilisateur, archive_adhésion, archive_donateur, archive_don qui sont des doublons des tables utilisateur, adhésion, donateur et don. 
Cette séparation des tables permet une optimisation des requêtes. Il existe des instances d'associations qui comportent plus de 400 000 membres (e.g. IEEE). 
Il aurait été possible de gérer l'archivage avec un simple attribut booléen.

On y stockerait uniquement les données qui datent d'il y a plus d'une certaine date. Par exemple, toutes données d'adhésion expirées vieilles de plus de 10 ans. L'historique des serait affecté, car on irait chercher les données vieilles de 10 ans que sur demande de l'utilisateur. 

Pour les utilisateurs, on pourrait imaginer archiver les utilisateurs inactifs de plus de 2 ans. On archiverait toutes les données les concernants à la fois. 

Pour les donateurs, on peut archiver les donateurs si leurs derniers dons datent d'il y a plus de 2 ans par exemple.

L'historique des adhésions fait également partie des archives.

### Groupe
Les données concernant les groupes sont périssables. Si le groupe est supprimé ou n'a plus de membres, les données concernant le groupe seront supprimées définitivement. Cela inclut les éventuels URLS/Fichiers/Evt qui y étaient liés.

## Exemples d'interfaces de l'application

### Page de connexion
La page de connexion ne nécessite pas de vues en particulier. Le mot de passe est envoyé par un protocole sécurisé au serveur, qui se chargera de l'encrypter et de la comparer au mot de passe utilisateur stocké dans la base de données.

### Page d'inscription
La page de connexion ne nécessite pas non plus de vues en particulier.

### Page profil utilisateur
> Page pour modifier ses coordonnées (nom, prénom, mail, mobile, adresse... certains champs sont facultatifs)

Toutes les informations relatives à l'utilisateur doivent y être présentes :
- nom, prénom, photo
- coordonnées personnelles : adresse postale, email, téléphone, site web, ...

### Page d'administration de l'association
> Page d'administration permettant de voir tous les gens inscrits sur le site, les personnes adhérentes, les informations pour chaque personne, les personnes dont l'adhésion a expiré, les cotisations qui vont expirer dans le mois qui vient, etc.
Cette page d'administration contient plusieurs vues :
- vue des adhérants, c'est-à-dire les utilisateurs dont les adhésions sont encore valides, ou encore dont les adhésions n'ont pas atteint leur date d'expiration;
- vue des profils utilisateurs, où toutes les informations concernant chaque utilisateur sont affichés;
- vue des ex-adhérants, où tous les utilisateurs dont les adhésions ont expiré sont affichés;
- vue des expirations proches, où tous les adhérants dont les adhésions expirent bientôt (1 mois par exemple) sont affichés.

### Page d'administration de saisie des adhérants et des dons
> Page d'administration permettant de saisir les adhésions et dons.
La page d'administration de saisie des adhérants et des dons ne nécessitent pas de vues ne particulier.

### Page d'administration des groupes
> Page d'administration permettant de gérer les groupes
La page d'administration des groupes doit afficher les groupes existants, et les informations relatives aux groupes : 
- informations du groupe;
- adhérants membres du groupe.

Cette page doit également permettre de créer/supprimer un groupe, ajouter/retirer des adhérants à un groupe.

### Page d'accès aux archives
Les archives concernent essentiellement : 
- l'historique des adhésions;
- l'historique des adhérents.

La page des archives pour un utilisateur contiendra :
- l'historique de ses adhésions (date début, date fin, type d'adhésion);
- l'historique de ses dons, s'il en a (date, montant).

La page des archives pour un administrateur contiendra :
- l'historique de toutes les adhésions (date début, date fin, type d'adhésion, nom, prénom, photo);
- l'historique de tous les dons (date, montant, nom complet s'il y a, utilisateur s'il y a).

On aura besoin d'une vue qui liste toutes les adhésions, d'une vue qui liste tous les dons. De ces deux vues, on peut obtenir une vue des adhésions et des dons pour un utilisateur en particulier.

### Page d'export
> Page d'export permettant aux administrateurs d'exporter la liste des adhérents dans un format CSV ou un format vCard.

La page est accessible aux administrateurs uniquement et contient un bouton permettant d'exporter la liste des adhérents dans un format CSV, ou Vcard.
