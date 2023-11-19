drop database if exists commercial;
create database commercial;
\c commercial;
CREATE SEQUENCE s_produit start WITH 1 INCREMENT BY 1;

CREATE TABLE Produit(
   id_produit VARCHAR(50) ,
   nom VARCHAR(100)  NOT NULL,
   reference VARCHAR(50)  NOT NULL,
   unite VARCHAR(50)  NOT NULL,
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
   id_fonction VARCHAR(50)  NOT NULL,
   id_departement VARCHAR(50) ,
   PRIMARY KEY(id_employe),
   FOREIGN KEY(id_fonction) REFERENCES Fonction(id_fonction),
   FOREIGN KEY(id_departement) REFERENCES Departement(id_departement)
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
SELECT d.id_produit, p.nom, p.reference, p.unite, d.quantite, d.id_besoin, d.status, d.id as id_demande
FROM demande d
   JOIN produit p ON d.id_produit=p.id_produit;

CREATE OR REPLACE VIEW v_liste_groupe AS
SELECT id_produit, nom, unite, reference, SUM(quantite) as quantite, status
FROM v_demande
WHERE status >= 10
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
   PRIMARY KEY(id_fournisseur)
);

CREATE SEQUENCE s_bon start WITH 1 INCREMENT BY 1;

CREATE TABLE bon_de_commande(
   id_commande VARCHAR(50) ,
   date_commande DATE,
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
   PRIMARY KEY(id_proforma),
   FOREIGN KEY(id_fournisseur) REFERENCES Fournisseur(id_fournisseur)
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
      p.*
   from detail_proforma as pf
   join produit as p 
   on pf.id_produit = p.id_produit;

CREATE OR REPLACE VIEW v_proforma AS
SELECT d.id_produit, p.nom, p.reference, p.unite, d.quantite, d.id_proforma, d.prix_unitaire, d.tva
FROM detail_proforma d
   JOIN produit p ON d.id_produit=p.id_produit;
