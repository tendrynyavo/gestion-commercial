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
   id_departement VARCHAR(50) ,
   PRIMARY KEY(id_employe),
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
   id_produit VARCHAR(50) ,
   id_besoin VARCHAR(50) ,
   quantite VARCHAR(50)  NOT NULL,
   PRIMARY KEY(id_produit, id_besoin),
   FOREIGN KEY(id_produit) REFERENCES Produit(id_produit),
   FOREIGN KEY(id_besoin) REFERENCES Besoin(id_besoin)
);