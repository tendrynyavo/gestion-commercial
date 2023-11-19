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