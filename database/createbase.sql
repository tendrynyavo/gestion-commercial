drop database if exists commercial;
create database commercial;
\c commercial;

CREATE SEQUENCE s_produit start WITH 1 INCREMENT BY 1;

CREATE TABLE Produit(
   id_produit VARCHAR(50) ,
   nom VARCHAR(100)  NOT NULL,
   reference VARCHAR(50)  NOT NULL,
   unite VARCHAR(50)  NOT NULL,
   tva double precision,
   PRIMARY KEY(id_produit)
);

CREATE SEQUENCE s_departement start WITH 1 INCREMENT BY 1;

CREATE TABLE Departement(
   id_departement VARCHAR(50) ,
   nom VARCHAR(100)  NOT NULL,
   PRIMARY KEY(id_departement)
);

CREATE SEQUENCE s_fonction start WITH 1 INCREMENT BY 1;

CREATE TABLE Fonction(
   id_fonction VARCHAR(50) ,
   nom VARCHAR(50)  NOT NULL,
   PRIMARY KEY(id_fonction)
);

CREATE SEQUENCE s_employe start WITH 1 INCREMENT BY 1;

CREATE TABLE Employe(
   id_employe VARCHAR(50) ,
   nom VARCHAR(100)  NOT NULL,
   prenom VARCHAR(100)  NOT NULL,
   telephone VARCHAR(50) ,
   genre VARCHAR(10)  NOT NULL,
   password VARCHAR(100)  NOT NULL,
   date_naissance DATE,
   email VARCHAR(100)  NOT NULL,
   id_departement varchar(50),
   id_fonction varchar(50),
   foreign key(id_departement) references Departement(id_departement),
   foreign key(id_fonction) references fonction(id_fonction),
   PRIMARY KEY(id_employe)
);

CREATE SEQUENCE s_societe start WITH 1 INCREMENT BY 1;

create table societe(
   id_societe varchar(50) primary key,
   nom_societe varchar(100),
   email varchar(100),
   mot_de_passe varchar(100)
);


CREATE SEQUENCE s_besoin start WITH 1 INCREMENT BY 1;

CREATE TABLE Besoin(
   id_besoin VARCHAR(50) ,
   description TEXT,
   date_besoin DATE,
   id_employe VARCHAR(50)  NOT NULL,
   PRIMARY KEY(id_besoin),
   FOREIGN KEY(id_employe) REFERENCES Employe(id_employe)
);

CREATE TABLE demande(
   id SERIAL PRIMARY KEY,
   id_produit VARCHAR(50) ,
   id_besoin VARCHAR(50) ,
   quantite DOUBLE PRECISION NOT NULL DEFAULT 0,
   status INTEGER NOT NULL DEFAULT 0,
   FOREIGN KEY(id_produit) REFERENCES Produit(id_produit),
   FOREIGN KEY(id_besoin) REFERENCES Besoin(id_besoin)
);

CREATE OR REPLACE VIEW v_demande AS
SELECT d.id_produit, p.nom, p.reference, p.unite, d.quantite, d.id_besoin, d.status, d.id as id_demande, e.id_departement
FROM demande d
   JOIN besoin b ON d.id_besoin=b.id_besoin
   JOIN employe e ON b.id_employe=e.id_employe
   JOIN produit p ON d.id_produit=p.id_produit;

CREATE OR REPLACE VIEW v_liste_groupe_departement AS
SELECT id_produit, nom, unite, reference, SUM(quantite) as quantite, status, id_departement
FROM v_demande
WHERE status >= 10
GROUP BY id_produit, nom, unite, reference, id_departement, status;

CREATE OR REPLACE VIEW v_liste_groupe AS
SELECT id_produit, nom, unite, reference, SUM(quantite) as quantite, status
FROM v_demande
WHERE status = 10
GROUP BY id_produit, nom, unite, reference, status;

-- Okey tokony mba misy vu mi-gerer ihany izany ilay izy raha izany hoe avy aiza ilay izy
-- Afaka atao izay zavatra izay
-- Andao ary atao hoe maka ny commande rehetra no anaovana azy
-- Izay angamba no mety kokoa
-- Tsy maka avy ao amin'ny liste groupe


CREATE SEQUENCE s_fournisseur start WITH 1 INCREMENT BY 1;

CREATE TABLE Fournisseur(
   id_fournisseur VARCHAR(50) ,
   nom VARCHAR(100)  NOT NULL,
   email VARCHAR(100)  NOT NULL,
   mot_de_passe varchar(100),
   PRIMARY KEY(id_fournisseur)
);

CREATE SEQUENCE s_bon start WITH 1 INCREMENT BY 1;

CREATE TABLE bon_de_commande(
   id_commande VARCHAR(50) ,
   date_commande TIMESTAMP,
   status INTEGER NOT NULL,
   mode_paiment VARCHAR(50) ,
   date_livraison DATE,
   avance DOUBLE PRECISION,
   id_fournisseur VARCHAR(50)  NOT NULL,
   PRIMARY KEY(id_commande),
   FOREIGN KEY(id_fournisseur) REFERENCES Fournisseur(id_fournisseur)
);

CREATE TABLE detail_commande(
   id_detail_commande SERIAL PRIMARY KEY,
   prix_unitaire DOUBLE PRECISION NOT NULL,
   tva VARCHAR(50)  NOT NULL,
   id_commande VARCHAR(50)  NOT NULL,
   id_demande INTEGER  NOT NULL,
   FOREIGN KEY(id_commande) REFERENCES bon_de_commande(id_commande),
   FOREIGN KEY(id_demande) REFERENCES Demande(id)
);

CREATE SEQUENCE s_proforma start WITH 1 INCREMENT BY 1;

CREATE TABLE Proforma(
   id_proforma VARCHAR(50) ,
   date_proforma DATE,
   id_fournisseur VARCHAR(50)  NOT NULL,
   id_societe varchar(50),
   PRIMARY KEY(id_proforma),
   FOREIGN KEY(id_fournisseur) REFERENCES Fournisseur(id_fournisseur),
   FOREIGN KEY(id_societe) REFERENCES societe(id_societe)
);

CREATE TABLE detail_proforma(
   id SERIAL PRIMARY KEY,
   id_produit VARCHAR(50) ,
   id_proforma VARCHAR(50) ,
   quantite DOUBLE PRECISION,
   prix_unitaire DOUBLE PRECISION,
   tva DOUBLE PRECISION NOT NULL,
   FOREIGN KEY(id_produit) REFERENCES Produit(id_produit),
   FOREIGN KEY(id_proforma) REFERENCES Proforma(id_proforma)
);


create or replace view v_detail_proforma_produit
   as
   select 
      pf.id, pf.id_proforma, pf.quantite, pf.prix_unitaire, pf.tva,
      p.id_produit,p.nom,p.reference,p.unite
   from detail_proforma as pf
   join produit as p 
   on pf.id_produit = p.id_produit;

CREATE OR REPLACE VIEW v_proforma AS
SELECT d.id_produit, p.nom, p.reference, p.unite, d.quantite, d.id_proforma, d.prix_unitaire, d.tva
FROM detail_proforma d
   JOIN produit p ON d.id_produit=p.id_produit;

CREATE or replace view v_detail_commande
   as
   select 
      d_c.id_detail_commande, d_c.prix_unitaire, d_c.tva, d_c.id_commande,
      v_d.*
   from detail_commande as d_c
   join v_demande as v_d
      on  d_c.id_demande = v_d.id_demande;

CREATE OR REPLACE VIEW v_bon_commande_fournisseur AS
SELECT b.*, f.nom, f.email
FROM bon_de_commande b
   JOIN Fournisseur f ON b.id_fournisseur=f.id_fournisseur;


-- The answer of Mark Byers is the optimal in this situation. Though in more complex situations you can take the select query that returns rowids and calculated values and attach it to the update query like this:

CREATE OR REPLACE VIEW v_demande_departement AS
SELECT d.*, e.id_departement
FROM demande d
   JOIN besoin b ON d.id_besoin=b.id_besoin
   JOIN employe e ON b.id_employe=e.id_employe;
   
UPDATE demande
SET status = 15
WHERE id IN (
   SELECT id
   FROM v_demande_departement v
   WHERE
      v.id_produit = 'ART009'
      AND v.id_departement = 'DEPT008'
      AND v.status = 10
);


SELECT *
FROM v_demande_departement v
WHERE
    v.id_produit = 'ART009'
    AND v.id_departement = 'DEPT008';

CREATE OR REPLACE VIEW v_detail_commande_groupe AS
SELECT id_commande, id_produit, unite, prix_unitaire, tva, nom, reference, SUM(quantite) AS quantite
FROM v_detail_commande
   GROUP BY id_commande, id_produit, unite, prix_unitaire, tva, nom, reference;
---------------------------------------------------------------------------------------------------------------------------------
create table employe_societe(
   id_employe varchar(50),
   id_societe varchar(50),
   date_debut date,
   date_fin date,
   foreign key(id_employe) references Employe(id_employe),
   foreign key(id_societe) references societe(id_societe)
);

create or replace view v_societe as
select es.id_employe,es.date_debut,es.date_fin,s.*
 from employe_societe as es 
 join societe as s on es.id_societe=s.id_societe where es.date_fin is null;

CREATE SEQUENCE s_mouvement start WITH 1 INCREMENT BY 1;

create table mouvement(
   id_mouvement varchar(50) primary key,
   date_mouvement date,
   id_produit VARCHAR(50) ,
   pu double precision,
   quantite double precision,
   type_mouvement int,
   id_fournisseur varchar(50),
   foreign key(id_fournisseur) references Fournisseur(id_fournisseur),
   foreign key(id_produit) references Produit(id_produit)
);

CREATE SEQUENCE s_demande_proforma start WITH 1 INCREMENT BY 1;

create table demande_proforma(
   id_demande_proforma varchar(50) primary key,
   id_societe varchar(50),
   id_fournisseur varchar(50),
   date_demande date,
   foreign key(id_societe) references societe(id_societe),
   foreign key(id_fournisseur) references Fournisseur(id_fournisseur)
);

create table detail_demande_proforma(
   id_detail_demande serial primary key,
   id_demande_proforma varchar(50),
   id_produit varchar(50),
   quantite double precision,
   etat int,
   foreign key(id_produit) references Produit(id_produit),
   foreign key(id_demande_proforma) references demande_proforma(id_demande_proforma)
);

CREATE OR REPLACE VIEW entree as 
select * 
from mouvement 
where type_mouvement=0;

CREATE OR REPLACE VIEW sortie as 
select * 
from mouvement 
where type_mouvement=1;

CREATE OR REPLACE VIEW v_demande_proforma as
select dpf.*,p.nom,p.reference,p.unite,p.tva 
from detail_demande_proforma as dpf 
join produit as p on p.id_produit=dpf.id_produit;

create or replace view v_detail_proforma as
select d.*,p.nom,p.reference,p.unite 
from detail_proforma as d
join produit as p on p.id_produit=d.id_produit;