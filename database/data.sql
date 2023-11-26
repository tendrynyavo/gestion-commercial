-- Insert data into Produit table
INSERT INTO Produit (id_produit, nom, reference, unite)
VALUES 
   ('ART00' || NEXTVAL('s_produit'), 'Ordinateur Portable', 'ORP', 'Unite'),
   ('ART00' || NEXTVAL('s_produit'), 'Ordinateur Fixe', 'ORF', 'Unite'),
   ('ART00' || NEXTVAL('s_produit'), 'Cache-bouche Bleu', 'CBB', 'Unite'),
   ('ART00' || NEXTVAL('s_produit'), 'Couleur Rouge', 'COUR', 'Litre'),
   ('ART00' || NEXTVAL('s_produit'), 'Couleur Vert', 'COUV', 'Litre');

-- Insert data into Departement table
INSERT INTO Departement (id_departement, nom)
VALUES 
   ('DEPT00' || NEXTVAL('s_departement'), 'Marketing'),
   ('DEPT00' || NEXTVAL('s_departement'), 'Comptabilite'),
   ('DEPT00' || NEXTVAL('s_departement'), 'IT');

-- Insert date into fonction
INSERT INTO fonction (id_fonction, nom)
VALUES 
   ('FON00' || NEXTVAL('s_fonction'), 'Chef de departement');

-- Insert data into Employe table
INSERT INTO Employe (id_employe, nom, prenom, telephone, genre, password, date_naissance, email, id_departement, id_fonction)
VALUES 
   ('EMP00' || NEXTVAL('s_employe'), 'John', 'Doe', '123456789', 'Male', 'password1', '1990-01-01', 'john.doe@email.com', (SELECT id_departement FROM Departement WHERE nom = 'Marketing'), 'FON001'),
   ('EMP00' || NEXTVAL('s_employe'), 'Jane', 'Doe', '987654321', 'Female', 'password2', '1995-05-15', 'jane.doe@email.com', (SELECT id_departement FROM Departement WHERE nom = 'Comptabilite'), 'FON001'),
   ('EMP00' || NEXTVAL('s_employe'), 'Bob', 'Smith', '555555555', 'Male', 'password3', '1985-08-20', 'bob.smith@email.com', (SELECT id_departement FROM Departement WHERE nom = 'IT'), 'FON001');

INSERT INTO Fournisseur (id_fournisseur, nom, email)
VALUES 
   ('FOUR'||LPAD(NEXTVAL('s_fournisseur')::TEXT, 3, '0'), 'ABC Electronics', 'abc.electronics@email.com'),
   ('FOUR'||LPAD(NEXTVAL('s_fournisseur')::TEXT, 3, '0'), 'XYZ Supplies', 'xyz.supplies@email.com'),
   ('FOUR'||LPAD(NEXTVAL('s_fournisseur')::TEXT, 3, '0'), 'Global Tech Solutions', 'global.tech@email.com');

update fournisseur set email='manoarysarobidy@gmail.com' where id_fournisseur ='FOUR001';
update fournisseur set mot_de_passe='wumw rzpf xzif jzxr' where id_fournisseur ='FOUR001';

insert into proforma values ('PRF00' || NEXTVAL('s_proforma') , '2023-10-10' , 'FOUR001');
insert into proforma values ('PRF00' || NEXTVAL('s_proforma') , '2023-10-11' , 'FOUR002');
insert into proforma values ('PRF00' || NEXTVAL('s_proforma') , '2023-10-12' , 'FOUR003');

insert into detail_proforma values (default, 'ART001', 'PRF001', 30, 2500000, 20);
insert into detail_proforma values (default, 'ART002', 'PRF001', 30, 1400000, 20);
insert into detail_proforma values (default, 'ART003', 'PRF001', 30, 6000, 20);

insert into detail_proforma values (default, 'ART001', 'PRF002', 30, 2000000, 20);
insert into detail_proforma values (default, 'ART004', 'PRF002', 30, 90000, 20);
insert into detail_proforma values (default, 'ART005', 'PRF002', 30, 80000, 20);

insert into detail_proforma values (default, 'ART001', 'PRF003', 30, 3800000, 20);
insert into detail_proforma values (default, 'ART002', 'PRF003', 30, 1500000, 20);
insert into detail_proforma values (default, 'ART003', 'PRF003', 30, 3000, 20);
insert into detail_proforma values (default, 'ART005', 'PRF003', 30, 75000, 20);


INSERT INTO societe (id_societe, nom_societe, email, mot_de_passe)
VALUES
  ('SCT001', 'Societe1', 'societe1@example.com', 'motdepasse1'),
  ('SCT002', 'Societe2', 'malalanirina030304@gmail.com', 'motdepasse2'),
  ('SCT003', 'Societe3', 'societe3@example.com', 'motdepasse3'),
  ('SCT004', 'Societe4', 'societe4@example.com', 'motdepasse4');

INSERT INTO employe_societe(id_employe, id_societe, date_debut)
values
   ('EMP001','SCT002','2023-01-01'),
   ('EMP002','SCT003','2023-11-10'),
   ('EMP003','SCT001','2023-12-04');

insert into mouvement 
values
('MVT001','2020-01-01','ART001',2300,10,0,'FOUR001'),
('MVT002','2020-10-01','ART001',2000,7,0,'FOUR001'),
('MVT003','2020-01-11','ART001',2300,2,1,'FOUR001');