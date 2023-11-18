-- drop database recrutement;

-- create database recrutement;
-- \c recrutement;

-- Categorie
   create table categorie(
      idCategorie serial primary key,
      nomCategorie varchar(30)
   );

-- Critere
   create table critere(
      idCritere serial primary key,
      nomCritere varchar(30),
      idCategorie integer not null,
      minimum double precision,
      maximum double precision,
      foreign key(idCategorie) references categorie(idCategorie)
   );

-- Addresse
   create table adresse(
       adresse varchar(30),
       idCritereVille integer not null,
       foreign key(idCritereVille) references critere(idCritere)
   );

-- Guest ( information de base d'une personne )
   create SEQUENCE sGuest start WITH 1 INCREMENT by 1;
   create table guest(
      idguest varchar(10) not null primary key,
      nom varchar(150),
      prenom varchar(150),
      datenaissance date,
      contact varchar(50),
      mail varchar(50),
      sexe int not null,
      work boolean default false,
      foreign key( sexe ) REFERENCES critere( idCritere )
   );



-- Candidature
   CREATE SEQUENCE sCandidature START WITH 1 INCREMENT BY 1;
   create table candidature(
      idCandidature varchar(7) not null primary key,
      idguest varchar(10) not null,
      dateCandidature date,
      salaire double precision,
      foreign key( idguest ) REFERENCES guest(idguest)
   );

   create table embauche(
      idcandidature varchar(7),
      dateEmbauche timestamp
   );


-- Critere candidature
   create table CritereCandidature(
      idcandidature varchar(7) not null,
      idCritere integer not null,
      foreign key(idCandidature) references candidature(idCandidature),
      foreign key(idCritere) references critere(idCritere)
   );


-- Details Annonces
   create table detailsAnnonce(
      idAnnonce varchar(7) not null,
      note double precision,
      idCritere integer not null,
      foreign key(idCritere) references critere(idCritere),
      foreign key(idAnnonce) references annonce(idAnnonce)
   );

-- Diplome
   create table diplome(
      idDiplome serial primary key,
      libelle varchar(20)
   );

-- Etude
   create table etude(
      idCandidature varchar(7) not null,
      idCritereDiplome integer not null,
      idCritereFiliere integer not null,
      diplome varchar,
      foreign key(idCritereDiplome) references critere(idcritere),
      foreign key(idCritereFiliere) references critere(idcritere),
      foreign key(idCandidature) references candidature(idCandidature)
   );

-- Experience
   CREATE SEQUENCE sExperience START WITH 1 INCREMENT BY 1;
   create table experience(
      idExperience varchar(7) primary key,
      idCandidature varchar(7) not null,
       certification varchar(30),
       entreprise varchar(50),
       nomposte varchar(30),
       idcritereDuree integer not null,
       foreign key(idCandidature) references candidature(idCandidature),
       foreign key(idCritereDuree) references critere(idCritere)
   );

-- Filiere
   create table filiere(
      idFiliere serial primary key,
      nomFiliere varchar(30)
   );

-- Services
   CREATE SEQUENCE sServices START WITH 1 INCREMENT BY 1;
   create table services(
       idServices varchar(7) primary key,
       nomService varchar(30)
   );

-- Back
   CREATE SEQUENCE sback START WITH 1 INCREMENT BY 1;
   create table back(
      idback varchar(10) primary key,
      idguest varchar(10) not null,
      mail varchar(100) not null unique,
      mdp varchar(50),
      admin boolean default false,
      foreign key( idguest ) REFERENCES guest (idguest)
   );


-- Poste
   CREATE SEQUENCE sPoste START WITH 1 INCREMENT BY 1;
   create table poste(
      idPoste varchar(7) primary key,
      nomPoste varchar(30),
      salaire double precision
   );


-- Association Poste a Services
   create table posteServices(
      idServices varchar(7) not null,
      idPoste varchar(7) not null,
      foreign key( idServices ) references services(idServices),
      foreign key( idPoste ) references poste(idPoste)
   );


-- Besoin
   CREATE SEQUENCE sBesoin START WITH 1 INCREMENT BY 1;
   create table besoin(
      idBesoin varchar(7) primary key,
      idServices varchar(7) not null,
      idPoste varchar(7) not null,
      volNec double precision,
      volExec double precision,
      date DATE NOT NULL DEFAULT CURRENT_DATE,
      foreign key(idServices) references services(idServices),
      foreign key(idPoste) references poste(idPoste)
   );

-- Candidature Besoin
   create table candidatureBesoin(
      idBesoin varchar(7) not null,
      idCandidature varchar(7) not null,
      dateDepot date,
      foreign key(idBesoin) references besoin(idBesoin),
      foreign key(idCandidature) references candidature(idCandidature)
   );

-- Annonce
   CREATE SEQUENCE sAnnonce START WITH 1 INCREMENT BY 1;
   create table annonce(
       idAnnonce varchar(7) primary key,
       idBesoin varchar(7) not null,
       dateAnnonce date,
       foreign key(idBesoin) references besoin(idBesoin)
   );

-- Depot candidature
   CREATE SEQUENCE sDepot START WITH 1 INCREMENT BY 1;
   create table depotCandidature(
      idDepot varchar(7) not null primary key,
      idannonce varchar(7) not null,
      idcandidature varchar(7) not null,
      foreign key( idannonce ) references annonce(idAnnonce),
      foreign key( idcandidature ) references candidature(idCandidature)

   );

-- Qualification
   create table qualification(
      qualification varchar(50),
      note double precision
   );

-- Question
   CREATE SEQUENCE sQuestion START WITH 1 INCREMENT BY 1;
   create table question(
      idQuestion varchar(7) primary key,
      legende varchar(100),
      coefficient integer
   );

-- Reponse
   CREATE SEQUENCE sReponse START WITH 1 INCREMENT BY 1;
   create table reponse(
      idReponse varchar(7) primary key,
      idQuestion varchar(7) not null,
      vraie integer,
      legende varchar(255),
      foreign key(idQuestion) references question(idQuestion)
   );

-- Resultat
   create table resultat(
      idAnnonce varchar(7) not null,
      idCandidature varchar(7) not null,
      foreign key (idCandidature) references candidature(idCandidature),
      foreign key (idAnnonce) references annonce(idAnnonce)
   );

-- Resultat Candidat
   create table resultatCandidat(
      idCandidature varchar(7) not null,
      idQuestion varchar(7) not null,
      idReponse varchar(7) not null,
      foreign key(idQuestion) references question(idQuestion),
      foreign key(idReponse) references reponse(idReponse),
      foreign key (idCandidature) references candidature(idCandidature)
   );

-- Test
   create table test(
      idAnnonce varchar(7) not null,
      idQuestion varchar(7) not null,
      foreign key(idAnnonce) references annonce(idAnnonce),
      foreign key(idQuestion) references question(idQuestion)
   );


   create table detailsAnnonce(
      idAnnonce varchar(7) not null,
      note double precision,
      idCritere integer not null,
      foreign key(idCritere) references critere(idCritere),
      foreign key(idAnnonce) references annonce(idAnnonce)
   );

-- Paramètres
   create table parameter(
      id serial primary key,
      name varchar(50) not null,
      value double precision
   );

-- Entretien
   create SEQUENCE sEntretien start with 1 INCREMENT by 1;
   create table entretien(
      idEntretien varchar(8) not null primary key,
      debut timestamp not null,
      fin timestamp not null,
      idCandidature varchar(7) not null,
      note double precision default 0,
      foreign key( idcandidature ) references candidature(idCandidature)
   );

-- Société
   create table society(
      name varchar(100) not null,
      director varchar(7) not null,
      siege varchar(100) not null,
      matricule varchar(50) not null,
      foreign key( director ) references guest(idguest)
   );

drop table works;
-- Travails a faire
   create table works(
      idWorks serial primary key,
      idPoste varchar(7) not null,
      legende varchar(150),
      foreign key( idPoste ) references poste(idPoste)
   );

-- Tokony hoe par rapport amin'ny post ilay izy

-- Lieu de travail

   create table lieu(
      idLieu serial primary key,
      lieu varchar(250)
   );

-- Type de Contrat
   create SEQUENCE sTypeContrat start WITH 1 INCREMENT BY 1;
   create table typeContrat(
      idType varchar(7) not null primary key,
      name varchar(50) not null,
      description varchar(100)
   );

drop table contrat cascade;
drop sequence sContrat;
-- Table contrat
   create sequence sContrat start with 1 INCREMENT by 1;
   create table contrat(
      idcontrat varchar(7) not null primary key,
      idCandidature varchar(10) not null,
      idposte varchar(7) not null,
      idemployeur varchar(10) not null,
      accepted boolean default false,
      foreign key( idcandidature ) references candidature(idCandidature),
      foreign key( idemployeur ) references guest(idguest),
      foreign key( idposte ) references poste(idPoste)
   );

drop table detailsContrat;
-- Details contrat
   create table detailsContrat(
      idDetails serial primary key,
      idcontrat varchar(7) not null,
      datedebut timestamp,
      datefin timestamp,
      idtype varchar(7) not null,
      salaire double precision,
      idLieu int not null,
      foreign key( idLieu ) references lieu(idLieu),
      foreign key( idcontrat ) references contrat(idcontrat),
      foreign key( idtype ) references typeContrat(idtype)
   );


drop table employe;
drop sequence sMatricule;
-- Employe ( Note : Tokony ampiana date )
create sequence sMatricule start with 1 INCREMENT by 1;
   create table employe(
      matricule varchar(7) not null primary key,
      idServices varchar(7) not null,
      idGuest varchar(10) not null,
      idPoste varchar(7) not null,
      superieur varchar(7),
      contrat varchar(7) not null,
      dateEmbauche date default now(),
      foreign key( idServices ) references services(idServices),
      foreign key( idGuest ) references guest(idguest),
      foreign key( idPoste ) references poste(idPoste),
      foreign key( superieur ) references employe( matricule ),
      foreign key( contrat ) references contrat( idcontrat )
   );

drop table avantage cascade;
-- Avantages
   create table avantage(
      id serial primary key,
      legende varchar(150),
      description varchar(150)
   );

drop table posteAvantage;
-- avantage poste
   create table posteAvantage(
      idPoste varchar(7) not null,
      avantage int not null,
      foreign key( idPoste ) references poste(idPoste),
      foreign key( avantage ) references avantage(id)
   );

------- View Section

   create or replace view backService as
      select b.idBack, b.mdp, b.admin, g.*
      from back as b
      join guest as g
            on b.idGuest = g.idGuest;

   create view critereCategorie as 
      select critere.*,categorie.nomCategorie 
      from critere 
      join categorie 
      on categorie.idcategorie=critere.idcategorie;

   create view vBesoin as 
      select besoin.*,services.nomService,poste.nomPoste,poste.salaire 
      from besoin 
      join services 
      on services.idServices=besoin.idServices 
      join poste 
      on poste.idPoste=besoin.idPoste;

   create view vPost as
      select p.*, pS.idServices
      from posteServices as pS
      join poste as p on pS.idPoste = p.idPoste;


   create view vTest as
      select q.*, t.idannonce
      from test as t
      join question as q
      on t.idquestion = q.idquestion;

   create view detailsCritere as 
      select detailsAnnonce.*,critere.nomCritere,categorie.nomCategorie
      from detailsAnnonce 
      join critere 
      on critere.idCritere=detailsAnnonce.idcritere
      join categorie 
      on categorie.idcategorie=critere.idCategorie;

   create view cvService as
      select cb.idBesoin , c.*,b.idservices, a.idAnnonce, a.dateAnnonce
      from candidatureBesoin as cb 
      join candidature as c
         on c.idcandidature=cb.idcandidature 
      join besoin as b 
            on b.idbesoin=cb.idbesoin
      join annonce as a 
            on a.idbesoin = cb.idBesoin
      join guest as g 
            on g.idGuest = c.idGuest;


   create view vEtude as
      select etude.*,diplome.libelle,filiere.nomfiliere from etude
      join diplome on diplome.idDiplome=etude.diplome
      join filiere on filiere.idfiliere=etude.idfiliere;
      
   create view vExperience as
    select experience.*,critere.nomcritere,critere.minimum,critere.maximum
    from experience 
    join critere on critere.idcritere=experience.idcritereduree;

   create view vCritereCandidature as
      select criterecandidature.*,critere.nomcritere,categorie.*
      from criterecandidature 
      join critere on critere.idcritere=criterecandidature.idcritere 
      join categorie on categorie.idcategorie=critere.idcategorie;

   create view vGeneralNote as
      select cc.idCandidature, dc.idannonce, dc.note, cr.*
      from critereCandidature as cc 
      join detailsCritere as dc
      on cc.idCritere = dc.idcritere
      join critere as cr
      on cr.idCritere = dc.idCritere;

   create view vAnswer as
      select rc.idCandidature, rc.idQuestion, rc.idReponse, r.vraie, r.legende
      from resultatCandidat as rc 
      join reponse as r 
      on rc.idReponse = r.idreponse;

   CREATE VIEW vCritere AS
   SELECT c.idCritere, c.nomCritere, d.idAnnonce, d.note, c.idCategorie, c.minimum, c.maximum
   FROM detailsAnnonce d
       JOIN critere c on d.idCritere = c.idCritere;

   create view vNoteCandidat as
      select dc.*, cd.idCandidature 
      from detailscritere as dc 
      join criterecandidature as cd 
      on dc.idcritere = cd.idcritere;

   -- Deprecated
   create view candidatureService as 
    select candidaturebesoin.idbesoin,annonce.idannonce,annonce.dateannonce,candidature.* 
    from candidatureBesoin 
    join annonce on annonce.idBesoin=candidaturebesoin.idbesoin 
    join candidature on candidature.idcandidature=candidatureBesoin.idCandidature;

   drop view candidatureService;

   create or replace view candidatureService as
      select 
         a.idAnnonce, a.idBesoin, a.dateannonce,
         c.*
      from depotCandidature as d
      join annonce as a
      on d.idAnnonce = a.idAnnonce
      join candidature as c 
      on c.idcandidature = d.idCandidature;

   create view vCandidatBesoinService as
   select 
      cv.idAnnonce, cv.dateAnnonce, cv.idCandidature, cv.idGuest, cv.dateCandidature,
      vb.*
   from candidatureService as cv 
   join vBesoin as vb 
   on cv.idBesoin = vb.idBesoin;

   create view vCandidatureService as
      select 
         cv.idBesoin, cv.idannonce, cv.dateannonce, cv.idCandidature, cv.datecandidature, cv.salaire,
         g.*
      from candidatureService as cv
      join guest as g
      on cv.idGuest = g.idGuest;

   create or replace view vCv as
      select 
         cv.*,
         e.idEntretien, e.debut, e.fin, e.note as noteEntretient
      from vCandidatureService as cv
      left join entretien as e
      on cv.idCandidature = e.idCandidature;

   -- Mila miteny hoe taiza ilay izy
   -- Donc mila tenenina hoe aiza

-- Mila miteny hoe taiza ilay izy
-- Donc mila tenenina hoe aiza

-- Mila mamorona view vaovao


--CONGE
create table conge(
   idConge integer primary key,
   raison varchar(100),
   duree double precision,
   max double precision
);

create table demandeConge(
   idDemande serial primary key,
   idConge integer,
   idEmp varchar(7) not null,
   dateDebut timestamp,
   dateFin timestamp,
   descriptions text,
   statut integer,
   foreign key(idEmp) references employe(matricule),
   foreign key(idConge) references conge(idConge)
);

create table EmpConge(
   idDemande integer,
   dateDebut timestamp,
   dateFin timestamp,
   foreign key(iddemande) references demandeConge(iddemande)
);

create view vDemandeConge as
select demandeConge.*,conge.raison
 from demandeConge
  join conge on conge.idconge=demandeconge.idconge;


create view vEmpDemande as
select e.datedebut as vdebut,e.datefin as vfin,d.* 
from empconge as e 
join demandeconge as d on d.iddemande=e.iddemande;

   -- Mila mamorona view vaovao

   create or replace view vPosteAvantage as
      select
         p.*,
         a.*
      from posteAvantage as pa
      join poste as p
         on pa.idPoste = p.idPoste
      join avantage as a
         on pa.avantage = a.id;

   create or replace view vEmploye as
      select
         e.dateEmbauche,
         s.*,
         g.*,
         p.*
      from employe as e
      join services as s
         on e.idServices = s.idServices
      join guest as g
         on g.idGuest = e.idGuest
      join poste as p
         on e.idPoste = p.idPoste;

CREATE SEQUENCE sFiche START WITH 1 INCREMENT BY 1;
CREATE TABLE fiche(
    idFiche VARCHAR(20) PRIMARY KEY,
    debut DATE NOT NULL,
    fin DATE NOT NULL,
    salaire DOUBLE PRECISION NOT NULL DEFAULT 0,
    date_creation DATE NOT NULL DEFAULT CURRENT_DATE,
    matricule VARCHAR(7) REFERENCES employe(matricule)
);

CREATE SEQUENCE sDesignation START WITH 1 INCREMENT BY 1;
CREATE TABLE designation (
    idDesignation VARCHAR(20) PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    unite VARCHAR(20),
    type INTEGER
);

CREATE TABLE detailfiche (
    id SERIAL PRIMARY KEY,
    idParent VARCHAR(20) REFERENCES fiche(idFiche),
    idDesignation VARCHAR(20) REFERENCES designation(idDesignation),
    nombre DOUBLE PRECISION,
    montant DOUBLE PRECISION NOT NULL DEFAULT 0
);

CREATE VIEW v_designation AS
    SELECT detailfiche.idDesignation, nom, nombre, montant, salaire, unite
    FROM detailfiche
        JOIN designation d on detailfiche.idDesignation = d.idDesignation
        JOIN fiche f on detailfiche.idParent = f.idFiche;

-- Okey ito amin'izay avy eo no angalako hoe iza ilay employé superieur ana post iray
-- Andao ange andramana eh
-- Joinena amin'ny employé fotsiny ito
create table superieur(
   id serial primary key,
   idPoste varchar(7) not null,
   idemploye varchar(7) not null,
   debutSuperieur timestamp not null,
   finSuperieur timestamp,
   foreign key( idPoste ) references poste(idPoste),
   foreign key( idemploye ) references employe(matricule)
);

-- Rehefa voa-join ito de azo ny supérieur courant ana post amin'izao

create or replace view vPostWithSuperior 
   as
      select
         s.id, s.debutSuperieur, s.finSuperieur,
         p.nomposte, p.salaire,
         e.*
      from superieur as s
      join poste as p
         on s.idPoste = p.idPoste
      join employe as e
         on e.matricule = s.idemploye;

create view vActiveSuperior
   as
      select
         *
      from vPostWithSuperior as vPwS
      where finSuperieur is null;

-- 

-- create or replace view vCandidatEmploye
--    as
--       select 
--          *
--       from contrat as c
--       join candidature as cd
--          on c.idcandidature = cd.idCandidature
--       join guest as g
--          on cd.idguest = g.idguest;


--    -- select  
--    --    distinct(c.idcontrat), c.idPoste, c.idemployeur,
--    --    cd.idCandidature, cd.idguest, cd.dateCandidature, cd.salaire,
--    --    e.matricule, e.idservices, e.superieur, e.dateEmbauche
--    -- from contrat as c
--    -- join candidature as cd
--    --    on c.idcandidature = cd.idCandidature
--    -- join employe as e
--    --    on cd.idguest = e.idguest;

CREATE SEQUENCE sType start WITH 1 INCREMENT BY 1;
CREATE TABLE type (
    idType VARCHAR(20) PRIMARY KEY,
    nom VARCHAR(50)
);

CREATE TABLE heure (
    id SERIAL PRIMARY KEY,
    matricule VARCHAR(7) REFERENCES employe(matricule),
    debut TIMESTAMP,
    fin TIMESTAMP,
    idType VARCHAR(20) REFERENCES type(idType)
);

CREATE TABLE intervalle (
    id SERIAL PRIMARY KEY,
    idType VARCHAR(20) REFERENCES type(idType),
    min DOUBLE PRECISION,
    max DOUBLE PRECISION,
    pourcentage DOUBLE PRECISION
);

CREATE VIEW v_heure_semaine_type AS
SELECT date_part('week', debut::date) as semaine, idType, matricule, SUM((EXTRACT(EPOCH FROM (fin - debut)) / 3600)) as temps, MIN(debut) as debut, MAX(fin) as fin
FROM heure
GROUP BY idType, semaine, matricule;

CREATE VIEW v_prime AS
    SELECT * FROM designation WHERE type = 1;

CREATE VIEW v_droit AS
SELECT * FROM designation WHERE type = 2;

CREATE VIEW v_heure AS
SELECT * FROM designation WHERE type = 3;

CREATE VIEW v_impot AS
SELECT * FROM designation WHERE type = 4;


create sequence spointage start with 1000 INCREMENT by 1;
create table pointage(

   idPointage varchar(7) not null primary key,
   idEmploye varchar(7) not null,
   entree timestamp,
   sortie timestamp

);