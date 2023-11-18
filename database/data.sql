    INSERT INTO services VALUES (concat('SRV', nextval('sServices')), 'Ressources Humaines');
INSERT INTO services VALUES (concat('SRV', nextval('sServices')), 'Comptabilité');
INSERT INTO services VALUES (concat('SRV', nextval('sServices')), 'Développement Informatique');
INSERT INTO services VALUES (concat('SRV', nextval('sServices')), 'Ventes');
INSERT INTO services VALUES (concat('SRV', nextval('sServices')), 'Marketing');
INSERT INTO services VALUES (concat('SRV', nextval('sServices')), 'Support Technique');

INSERT INTO back VALUES (concat('ADM', nextval('sback')),'GST1', 'Admin1', 'motdepasse1', true);
INSERT INTO back VALUES (concat('ADM', nextval('sback')),'GST2', 'Admin2', 'motdepasse2', true);
INSERT INTO back VALUES (concat('ADM', nextval('sback')),'GST3', 'Admin3', 'motdepasse3', true);

INSERT INTO poste VALUES (concat('PST', nextval('sPoste')), 'Ingénieur logiciel', 60000.00);
INSERT INTO poste VALUES (concat('PST', nextval('sPoste')), 'Analyste financier', 75000.00);
INSERT INTO poste VALUES (concat('PST', nextval('sPoste')), 'Responsable des ventes', 80000.00);
INSERT INTO poste VALUES (concat('PST', nextval('sPoste')), 'Développeur web', 55000.00);
INSERT INTO poste VALUES (concat('PST', nextval('sPoste')), 'Chef de projet', 70000.00);
INSERT INTO poste VALUES (concat('PST', nextval('sPoste')), 'Comptable', 60000.00);

INSERT INTO besoin VALUES (concat('BES', nextval('sBesoin')), 'SRV1', 'PST1', 5, 3);
INSERT INTO besoin VALUES (concat('BES', nextval('sBesoin')), 'SRV2', 'PST2', 3, 2);
INSERT INTO besoin VALUES (concat('BES', nextval('sBesoin')), 'SRV3', 'PST3', 7, 5);
INSERT INTO besoin VALUES (concat('BES', nextval('sBesoin')), 'SRV1', 'PST4', 4, 4);
INSERT INTO besoin VALUES (concat('BES', nextval('sBesoin')), 'SRV2', 'PST5', 6, 6);

INSERT INTO categorie(nomCategorie) VALUES ('sexe');
INSERT INTO categorie(nomCategorie) VALUES ('nationalite');
INSERT INTO categorie(nomCategorie) VALUES ('situation_matrimoniale');
INSERT INTO categorie(nomCategorie) VALUES ('ville');
INSERT INTO categorie(nomCategorie) VALUES ('diplome');
INSERT INTO categorie(nomCategorie) VALUES ('filiere');
INSERT INTO categorie(nomCategorie) VALUES ('experience');
INSERT INTO categorie(nomCategorie) VALUES ('salaire');


INSERT INTO critere VALUES (default,'Homme', 1, NULL, NULL);
INSERT INTO critere VALUES (default,'Femme', 1, NULL, NULL);
INSERT INTO critere VALUES (default,'Autre', 1, NULL, NULL);

INSERT INTO critere VALUES (default,'Malagasy', 2, NULL, NULL);
INSERT INTO critere VALUES (default,'Française', 2, NULL, NULL);
INSERT INTO critere VALUES (default,'Anglaise', 2, NULL, NULL);

INSERT INTO critere VALUES (default,'Marié(e)', 3, NULL, NULL);
INSERT INTO critere VALUES (default,'Célibataire', 3, NULL, NULL);
INSERT INTO critere VALUES (default,'Divorcé(e)', 3, NULL, NULL);
INSERT INTO critere VALUES (default,'Veuf/Veuve', 3, NULL, NULL);
INSERT INTO critere VALUES (default,'Séparé(e)', 3, NULL, NULL);
INSERT INTO critere VALUES (default,'Autres', 3, NULL, NULL);

INSERT INTO critere VALUES (default,'Toamasina', 4, NULL, NULL);
INSERT INTO critere VALUES (default,'Antananarivo', 4, NULL, NULL);
INSERT INTO critere VALUES (default,'Mahajanga', 4, NULL, NULL);
INSERT INTO critere VALUES (default,'Antsiranana', 4, NULL, NULL);
INSERT INTO critere VALUES (default,'Toliara', 4, NULL, NULL);
INSERT INTO critere VALUES (default,'Fianarantsoa', 4, NULL, NULL);

INSERT INTO critere VALUES (default,'Licence', 5, NULL, NULL);
INSERT INTO critere VALUES (default,'Master', 5, NULL, NULL);
INSERT INTO critere VALUES (default,'Doctorat', 5, NULL, NULL);

INSERT INTO critere VALUES (default,'Informatique', 6, NULL, NULL);
INSERT INTO critere VALUES (default,'Génie civil', 6, NULL, NULL);
INSERT INTO critere VALUES (default,'Sciences économiques', 6, NULL, NULL);
INSERT INTO critere VALUES (default,'Médecine', 6, NULL, NULL);
INSERT INTO critere VALUES (default,'Arts et Lettres', 6, NULL, NULL);
INSERT INTO critere VALUES (default,'Sciences politiques', 6, NULL, NULL);
INSERT INTO critere VALUES (default,'Chimie', 6, NULL, NULL);
INSERT INTO critere VALUES (default,'Biologie', 6, NULL, NULL);
INSERT INTO critere VALUES (default,'Mathématiques', 6, NULL, NULL);

INSERT INTO critere VALUES (default,'Moins de 1 an', 7, 0, 1);
INSERT INTO critere VALUES (default,'Entre 1 et 3 ans', 7, 1, 3);
INSERT INTO critere VALUES (default,'Entre 3 et 5 ans', 7, 3, 5);
INSERT INTO critere VALUES (default,'Entre 5 et 7 ans', 7, 5, 7);
INSERT INTO critere VALUES (default,'Plus de 7 ans', 7, 7, 10000);

INSERT INTO critere VALUES (default,'Moins de 100 000 Ar ', 8, 0, 100000);
INSERT INTO critere VALUES (default,'Entre 100 000 et 300 000 Ar', 8, 100000, 300000);
INSERT INTO critere VALUES (default,'Entre 300 000 Ar et 500 000 Ar', 8, 300000, 500000);
INSERT INTO critere VALUES (default,'Entre 500 000 et 700 000 Ar', 8, 500000, 700000);
INSERT INTO critere VALUES (default,'Entre 700 000 et 1 000 000 Ar', 8, 700000, 1000000);
INSERT INTO critere VALUES (default,'Plus de 1 000 000 Ar', 8, 1000000, 10000000);

INSERT INTO diplome VALUES (default,'Licence');
INSERT INTO diplome VALUES (default,'Master');
INSERT INTO diplome VALUES (default,'Doctorat');

INSERT INTO filiere VALUES (default,'Informatique');
INSERT INTO filiere VALUES (default,'Génie civil');
INSERT INTO filiere VALUES (default,'Sciences économiques');
INSERT INTO filiere VALUES (default,'Médecine');
INSERT INTO filiere VALUES (default,'Arts et Lettres');
INSERT INTO filiere VALUES (default,'Sciences politiques');
INSERT INTO filiere VALUES (default,'Chimie');
INSERT INTO filiere VALUES (default,'Biologie');
INSERT INTO filiere VALUES (default,'Mathématiques');

INSERT INTO annonce VALUES (concat('ANN', nextval('sAnnonce')), 'BES1', '2023-10-01');
INSERT INTO annonce VALUES (concat('ANN', nextval('sAnnonce')), 'BES2', '2023-10-02');
INSERT INTO annonce VALUES (concat('ANN', nextval('sAnnonce')), 'BES3', '2023-10-03');
INSERT INTO annonce VALUES (concat('ANN', nextval('sAnnonce')), 'BES4', '2023-10-04');
INSERT INTO annonce VALUES (concat('ANN', nextval('sAnnonce')), 'BES5', '2023-10-05');

INSERT INTO detailsAnnonce VALUES('ANN1', 4.5, 1);  
INSERT INTO detailsAnnonce VALUES('ANN1', 3.0, 2); 
INSERT INTO detailsAnnonce VALUES('ANN1', 4.8, 3);  
INSERT INTO detailsAnnonce VALUES('ANN1', 4.0, 4); 
INSERT INTO detailsAnnonce VALUES('ANN1', 6.0, 5); 
INSERT INTO detailsAnnonce VALUES('ANN1', 2.0, 6); 
INSERT INTO detailsAnnonce VALUES('ANN1', 5.0, 7); 
INSERT INTO detailsAnnonce VALUES('ANN1', 3.5, 8); 
INSERT INTO detailsAnnonce VALUES('ANN2', 4.0, 1);  
INSERT INTO detailsAnnonce VALUES('ANN2', 3.5, 2); 
INSERT INTO detailsAnnonce VALUES('ANN2', 4.1, 3);  
INSERT INTO detailsAnnonce VALUES('ANN2', 3.2, 4); 
INSERT INTO detailsAnnonce VALUES('ANN2', 6.0, 5); 
INSERT INTO detailsAnnonce VALUES('ANN2', 2.5, 6); 
INSERT INTO detailsAnnonce VALUES('ANN2', 5.0, 7); 
INSERT INTO detailsAnnonce VALUES('ANN2', 3.5, 8); 

--- Sarobidy
insert into guest values ( concat('GST', nextval('sGuest')), 'RANDRIAHAVANA', 'Manoary Sarobidy', to_date('2003-01-01', 'YYYY-MM-DD'), '+261 34 24 356 32', 'monsterj152@gmail.com', 1 , false );
insert into guest values ( concat('GST', nextval('sGuest')), 'RAZAFIMIANDRISOA', 'Tendry Ny Avo', to_date('2004-04-02', 'YYYY-MM-DD'), '+261 34 24 356 32', 'tendryj152@gmail.com', 1 , false );
insert into guest values ( concat('GST', nextval('sGuest')), 'MALALANIRINA', 'Antsa Fitahiana', to_date('2004-03-04', 'YYYY-MM-DD'), '+261 34 24 356 32', 'antsaj152@gmail.com', 2 , false );

insert into candidature VALUES ( concat('CAN', nextval('sCandidature')), 'GST1', to_date('2023-05-10', 'YYYY-MM-DD'), 10000 );
insert into candidature VALUES ( concat('CAN', nextval('sCandidature')), 'GST2', to_date('2023-05-10', 'YYYY-MM-DD'), 10000 );
insert into candidature VALUES ( concat('CAN', nextval('sCandidature')), 'GST3', to_date('2023-05-10', 'YYYY-MM-DD'), 10000 );

insert into lieu values (default, 'Emplacement Ambohimanarina');
insert into lieu values (default, 'Emplacement Andoharanofotsy');
insert into lieu values (default, 'Emplacement Antanimena');
insert into lieu values (default, 'Emplacement Andrefana''Ambohijanahary');

insert into typecontrat values( concat('TPCTR', nextval('stypecontrat')), 'CE' , 'Contrat d''Essai' );
insert into typecontrat values( concat('TPCTR', nextval('stypecontrat')), 'CDI', 'Contrat a duree Indetermine' );
insert into typecontrat values( concat('TPCTR', nextval('stypecontrat')), 'CDD', 'Contrat a duree determine' );

insert into contrat values ( concat('CTR', nextval('scontrat')), 'CAN1', 'PST1', 'GST1', false );
insert into contrat values ( concat('CTR', nextval('scontrat')), 'CAN2', 'PST2', 'GST1', false );
insert into contrat values ( concat('CTR', nextval('scontrat')), 'CAN3', 'PST3', 'GST1', false );

insert into detailsContrat values ( default, 'CTR1', '2023-01-01', '2024-01-01', 'TPCTR1', 200000 , 1);
insert into detailsContrat values ( default, 'CTR2', '2023-01-01', '2024-01-01', 'TPCTR1', 250000 , 1);
insert into detailsContrat values ( default, 'CTR3', '2023-01-01', '2024-01-01', 'TPCTR1', 210000 , 1);

insert into employe(matricule, idServices, idguest, idposte, contrat) values ( concat('EMP', nextval('sMatricule')), 'SRV1', 'GST1', 'PST1', 'CTR1');
insert into employe(matricule, idServices, idguest, idposte, contrat) values ( concat('EMP', nextval('sMatricule')), 'SRV2', 'GST2', 'PST2', 'CTR2');
insert into employe(matricule, idServices, idguest, idposte, contrat) values ( concat('EMP', nextval('sMatricule')), 'SRV3', 'GST3', 'PST3', 'CTR3');
insert into employe(matricule, idServices, idguest, idposte) values ( concat('EMP', nextval('sMatricule')), 'SRV1', 'GST1', 'PST1');
insert into employe(matricule, idServices, idguest, idposte) values ( concat('EMP', nextval('sMatricule')), 'SRV2', 'GST2', 'PST2');
insert into employe(matricule, idServices, idguest, idposte) values ( concat('EMP', nextval('sMatricule')), 'SRV3', 'GST3', 'PST3');
insert into employe(matricule, idServices, idguest, idposte,superieur) values ( concat('EMP', nextval('sMatricule')), 'SRV4', 'GST1', 'PST4','EMP1');
insert into employe(matricule, idServices, idguest, idposte,superieur) values ( concat('EMP', nextval('sMatricule')), 'SRV5', 'GST2', 'PST5','EMP2');
insert into employe(matricule, idServices, idguest, idposte,superieur) values ( concat('EMP', nextval('sMatricule')), 'SRV6', 'GST3', 'PST6','EMP3');

-- insert into employes(matricule, idServices, idguest, idposte) values ( concat('EMP', nextval('sMatricule')), 'SRV3', 'GST3', 'PST3');

-- Fin Sarobidy

INSERT INTO Criterecandidature VALUES ('CAN1',1);
INSERT INTO Criterecandidature VALUES ('CAN1',8);
INSERT INTO Criterecandidature VALUES ('CAN1',4);
INSERT INTO Criterecandidature VALUES ('CAN2',2);
INSERT INTO Criterecandidature VALUES ('CAN2',9);
INSERT INTO Criterecandidature VALUES ('CAN2',4);
INSERT INTO Criterecandidature VALUES ('CAN3',1);
INSERT INTO Criterecandidature VALUES ('CAN3',2);
INSERT INTO Criterecandidature VALUES ('CAN3',5);

INSERT INTO adresse VALUES ('Avenue Andrianampoinimerina', 14);
INSERT INTO adresse VALUES('Avenue de l''Indépendance ', 15);
INSERT INTO adresse VALUES('Boulevard de Tokyo', 16);
INSERT INTO adresse VALUES('Rue Emile Ralambo', 17);
INSERT INTO adresse VALUES('Rue Docteur Ramanantsirava', 18);

INSERT INTO etude VALUES('CAN1', 19,22,'/bureau/certificat.pdf');
INSERT INTO etude VALUES('CAN1', 20,25,'/bureau/certificat.pdf');
INSERT INTO etude VALUES('CAN2', 21,27,'/bureau/certificat.pdf');
INSERT INTO etude VALUES('CAN3', 19,29,'/bureau/certificat.pdf');
INSERT INTO etude VALUES('CAN4', 321,30,'/bureau/certificat.pdf');

INSERT INTO experience VALUES (concat('EXP', nextval('sExperience')), 'CAN1', 'C:\Users\Antsa\Desktop\pic.png','STAR', 'Développeur Web',32);
INSERT INTO experience VALUES(concat('EXP', nextval('sExperience')), 'CAN2', 'C:\Users\Antsa\Desktop\pic.png','Socobis', 'Ingénieur Civil',31);
INSERT INTO experience VALUES(concat('EXP', nextval('sExperience')), 'CAN3', 'C:\Users\Antsa\Desktop\pic.png','JB', 'Analyste Financier',32);

INSERT INTO question VALUES (concat('QST', nextval('sQuestion')), 'Quelle est votre expérience en programmation Java?', 5);
INSERT INTO question VALUES (concat('QST', nextval('sQuestion')), 'Pouvez-vous décrire un projet sur lequel vous avez travaillé récemment?', 4);
INSERT INTO question VALUES (concat('QST', nextval('sQuestion')), 'Comment gérez-vous les délais serrés?', 3);
INSERT INTO question VALUES (concat('QST', nextval('sQuestion')), 'Quelles sont vos compétences en gestion de projet?', 4);
INSERT INTO question VALUES (concat('QST', nextval('sQuestion')), 'Comment abordez-vous la résolution de problèmes complexes?', 5);

INSERT INTO reponse VALUES (concat('RPS', nextval('sReponse')), 'QST1', 1, 'J''ai plus de 5 ans d''expérience en programmation Java.');
INSERT INTO reponse VALUES (concat('RPS', nextval('sReponse')), 'QST1', 0,'J''ai une expérience limitée en programmation Java.');
INSERT INTO reponse VALUES (concat('RPS', nextval('sReponse')), 'QST2', 1, 'J''ai récemment travaillé sur un projet de développement web pour une grande entreprise.');
INSERT INTO reponse VALUES (concat('RPS', nextval('sReponse')), 'QST2', 0, 'Je n''ai pas d''expérience récente en développement web.');
INSERT INTO reponse VALUES (concat('RPS', nextval('sReponse')), 'QST3', 0, 'Je trouve difficile de gérer des délais serrés.');
INSERT INTO reponse VALUES (concat('RPS', nextval('sReponse')), 'QST3', 1, 'Ca va je m''en sors pas mal');
INSERT INTO reponse VALUES (concat('RPS', nextval('sReponse')), 'QST3', 1, 'Je suis habitué à travailler sous pression et à respecter les délais.');
INSERT INTO reponse VALUES (concat('RPS', nextval('sReponse')), 'QST4', 1, 'J''ai une certification en gestion de projet et j''ai géré plusieurs projets avec succès.');
INSERT INTO reponse VALUES (concat('RPS', nextval('sReponse')), 'QST4', 0, 'Je n''ai pas de certification en gestion de projet.');
INSERT INTO reponse VALUES (concat('RPS', nextval('sReponse')), 'QST4', 0, 'Je sais gerer même sans certification');
INSERT INTO reponse VALUES (concat('RPS', nextval('sReponse')), 'QST5', 1, 'J''aborde la résolution de problèmes complexes en analysant d''abord le problème et en identifiant des solutions possibles.');
INSERT INTO reponse VALUES (concat('RPS', nextval('sReponse')), 'QST5', 0,  'Je préfère laisser le problème se résoudre de lui-même.');
INSERT INTO reponse VALUES (concat('RPS', nextval('sReponse')), 'QST5', 0,  'Je deteste ça');

INSERT INTO test VALUES ('ANN1','QST1');
INSERT INTO test VALUES ('ANN1','QST2');
INSERT INTO test VALUES ('ANN2','QST3');
INSERT INTO test VALUES ('ANN2','QST4');
INSERT INTO test VALUES ('ANN2','QST5');
INSERT INTO test VALUES ('ANN3','QST1');
INSERT INTO test VALUES ('ANN3','QST2');
INSERT INTO test VALUES ('ANN3','QST3');
INSERT INTO test VALUES ('ANN4','QST1');
INSERT INTO test VALUES ('ANN4','QST4');
INSERT INTO test VALUES ('ANN5','QST5');

INSERT INTO resultatCandidat VALUES ('CAN1','QST1','RPS1');
INSERT INTO resultatCandidat VALUES ('CAN1','QST2','RPS3');
INSERT INTO resultatCandidat VALUES ('CAN1','QST3','RPS6');
INSERT INTO resultatCandidat VALUES ('CAN1','QST3','RPS7');
INSERT INTO resultatCandidat VALUES ('CAN1','QST4','RPS10');
INSERT INTO resultatCandidat VALUES ('CAN1','QST5','RPS12');
INSERT INTO resultatCandidat VALUES ('CAN2','QST1','RPS2');
INSERT INTO resultatCandidat VALUES ('CAN2','QST2','RPS4');
INSERT INTO resultatCandidat VALUES ('CAN2','QST3','RPS5');
INSERT INTO resultatCandidat VALUES ('CAN2','QST4','RPS10');
INSERT INTO resultatCandidat VALUES ('CAN2','QST5','RPS11');

INSERT INTO resultat VALUES ('ANN1','CAN1');
INSERT INTO resultat VALUES ('ANN2','CAN2');

INSERT INTO posteServices VALUES('SRV3','PST1');
INSERT INTO posteServices VALUES('SRV3','PST4');
INSERT INTO posteServices VALUES('SRV3','PST5');
INSERT INTO posteServices VALUES('SRV4','PST3');
INSERT INTO posteServices VALUES('SRV2','PST6');
INSERT INTO posteServices VALUES('SRV5','PST2');


INSERT INTO qualification VALUES('Très recommandé',100);
INSERT INTO qualification VALUES('Recommandé',75);
INSERT INTO qualification VALUES('Admissible',50);
INSERT INTO qualification VALUES('Toléré',25);
INSERT INTO qualification VALUES('Passable',1);


INSERT INTO candidatureBesoin VALUES('BES1','CAN1');
INSERT INTO candidatureBesoin VALUES('BES1','CAN2');
INSERT INTO candidatureBesoin VALUES('BES2','CAN3');

insert into parameter values
	(default, 'Note qualificatif', 25),
	(default, 'Duree d''entretien', 30),
	(default, 'Nombre d''entretien par jour', 2),
	(default, 'Nombre de personnes', 3);

--conge

insert into conge values
(5,'Maternite',98,0),
(10,'Paternite',15,0),
(15,'Repos Medical',0,7),
(20,'Specifique',0,10),
(25,'Autres',0,30);

insert into embauche values
('CAN1','2022-11-01 10:00:00');

-- Insérer de nouveaux avantages avec des descriptions
INSERT INTO avantage (legende, description) VALUES ('Transport en commun gratuit', 'Profitez du transport en commun gratuit pour vous rendre au travail sans frais supplémentaires.');
INSERT INTO avantage (legende, description) VALUES ('Assurance maladie subventionnée', 'Bénéficiez d''une couverture d''assurance maladie à un coût réduit grâce à l''aide de l''entreprise.');
INSERT INTO avantage (legende, description) VALUES ('Participation aux bénéfices', 'Recevez une part des bénéfices de l''entreprise en tant qu''employé.');
INSERT INTO avantage (legende, description) VALUES ('Programme de formation continue', 'Accédez à des programmes de formation et de développement professionnel pour améliorer vos compétences.');
INSERT INTO avantage (legende, description) VALUES ('Journées de congé flexibles', 'Ayez la flexibilité de choisir vos jours de congé en fonction de vos besoins personnels.');
INSERT INTO avantage (legende, description) VALUES ('Restaurant d''entreprise', 'Profitez de repas abordables dans le restaurant de l''entreprise.');
INSERT INTO avantage (legende, description) VALUES ('Plan d''épargne retraite', 'Épargnez pour votre retraite avec l''aide de l''entreprise via un plan de retraite.');
INSERT INTO avantage (legende, description) VALUES ('Salle de sport sur place', 'Accédez à une salle de sport sur le lieu de travail pour rester en forme.');
INSERT INTO avantage (legende, description) VALUES ('Garderie d''entreprise', 'Bénéficiez d''une garderie sur place pour prendre soin de vos enfants pendant les heures de travail.');
INSERT INTO avantage (legende, description) VALUES ('Congés payés supplémentaires', 'Recevez des jours de congé supplémentaires pour plus de temps libre.');
INSERT INTO avantage (legende, description) VALUES ('Carte cadeau de Noël', 'Recevez une carte-cadeau à Noël pour faire des achats de fin d''année.');
INSERT INTO avantage (legende, description) VALUES ('Assistance juridique', 'Accédez à une assistance juridique pour résoudre des problèmes juridiques personnels.');
INSERT INTO avantage (legende, description) VALUES ('Accès à des cours en ligne gratuits', 'Obtenez gratuitement un accès à des cours en ligne pour l''apprentissage continu.');
INSERT INTO avantage (legende, description) VALUES ('Prime de performance', 'Recevez des primes en fonction de vos performances exceptionnelles.');
INSERT INTO avantage (legende, description) VALUES ('Journées de télétravail', 'Bénéficiez de la possibilité de travailler depuis chez vous de manière régulière ou occasionnelle.');

insert into posteAvantage values ('PST1' , 1);
insert into posteAvantage values ('PST1' , 2);
insert into posteAvantage values ('PST1' , 3);
insert into posteAvantage values ('PST1' , 4);
insert into posteAvantage values ('PST1' , 5);
insert into posteAvantage values ('PST1' , 6);
insert into posteAvantage values ('PST1' , 7);

insert into posteAvantage values ('PST2' , 1);
insert into posteAvantage values ('PST2' , 2);
insert into posteAvantage values ('PST2' , 3);
insert into posteAvantage values ('PST2' , 4);
insert into posteAvantage values ('PST2' , 5);
insert into posteAvantage values ('PST2' , 6);
insert into posteAvantage values ('PST2' , 7);

insert into posteAvantage values ('PST3' , 1);
insert into posteAvantage values ('PST3' , 7);
insert into posteAvantage values ('PST3' , 8);
insert into posteAvantage values ('PST3' , 10);

INSERT INTO society VALUES ('SOCIETE 1', 'GST1', 'Andoharanofotsy 102', 'MATR0000123');

INSERT INTO designation(idDesignation, nom, unite, type) VALUES
    (concat('DES000', nextval('sDesignation')), 'Prime de rendement', null, 1),
    (concat('DES000', nextval('sDesignation')), 'Prime anciennete', null, 1),
    (concat('DES000', nextval('sDesignation')), 'Droit de conge', 'j', 2),
    (concat('DES000', nextval('sDesignation')), 'Droit de preavis', 'j', 2),
    (concat('DES000', nextval('sDesignation')), 'Heures supplémentaires majorées de 30%', 'h', 3),
    (concat('DES000', nextval('sDesignation')), 'Heures supplémentaires majorées de 40%', 'h', 3),
    (concat('DES000', nextval('sDesignation')), 'Heures supplémentaires majorées de 50%', 'h', 3),
    (concat('DES000', nextval('sDesignation')), 'Heures supplémentaires majorées de 100%', 'h', 3),
    (concat('DES000', nextval('sDesignation')), 'Tranche IRSA', null, 4);


insert into superieur values (default, 'PST1', 'EMP1', to_date('2023-01-01', 'YYYY-MM-DD'), to_date('2023-03-01', 'YYYY-MM-DD'));
insert into superieur values (default, 'PST1', 'EMP1', to_date('2023-03-02', 'YYYY-MM-DD'), null);
insert into superieur values (default, 'PST2', 'EMP2', to_date('2023-01-01', 'YYYY-MM-DD'), to_date('2023-06-01', 'YYYY-MM-DD'));
insert into superieur values (default, 'PST2', 'EMP2', to_date('2023-07-02', 'YYYY-MM-DD'), null);
insert into superieur values (default, 'PST3', 'EMP3', to_date('2023-01-01', 'YYYY-MM-DD'), null);

INSERT INTO type VALUES
    (concat('TYP000', nextval('sType')), 'normale'),
    (concat('TYP000', nextval('sType')), 'week-end'),
    (concat('TYP000', nextval('sType')), 'ferier'),
    (concat('TYP000', nextval('sType')), 'Tranche IRSA');

INSERT INTO intervalle (idType, min, max, pourcentage) VALUES
    ('TYP0001', 0, 8, 30),
    ('TYP0001', 8, 12, 50),
    ('TYP0002', 0, 'infinity', 40),
    ('TYP0003', 0, 'infinity', 100),
    ('TYP0004', 350000, 400000, 5),
    ('TYP0004', 400000, 500000, 10),
    ('TYP0004', 500000, 600000, 15),
    ('TYP0004', 600000, 'infinity', 20);

-- insert into superieur values (default, 'PST4', 'EMP0010', to_date('2023-01-01', 'YYYY-MM-DD'), null);
