USE guest;

DROP DATABASE IF EXISTS SUPERMERCADO;

CREATE DATABASE IF NOT EXISTS SUPERMERCADO;
USE SUPERMERCADO;

DROP TABLE IF EXISTS FUNCIONARIO, PRODUTO, FORNECEDOR, LOJA, TELEMOVEL, TRABALHA_PARA, CATEGORIA;

CREATE TABLE FORNECEDOR (
 
 NumId INT PRIMARY KEY AUTO_INCREMENT,
 NomeFornecedor VARCHAR(64) NOT NULL
);

INSERT INTO FORNECEDOR(NumId,NomeFornecedor)
VALUES
(4000 , 'DarkStates' ),
(4001 , 'Magnolia' ),
(4002 , 'DragonEmpire'),
(4003 , 'Narukuma'),
(4004 , 'DaGhost'),
(4005 , 'LightPaladins'),

DROP TABLE IF EXISTS FUNCIONARIO;
CREATE TABLE FUNCIONARIO (

 NumId INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
 Nome VARCHAR(128) NOT NULL,
 DataNasc DATE NOT NULL,
 Salario decimal(6,2) DEFAULT NULL,
 Email VARCHAR(64) NOT NULL,
 Supervisor INT NOT NULL,
 KEY Supervisor(Supervisor)
 
);

CONSTRAINT `FUNCIONARIO_ibfk_1` FOREIGN KEY(`Supervisor`) REFERENCES FUNCIONARIO(`NumId`) ON UPDATE CASCADE;

INSERT INTO FUNCIONARIO(NumId,Nome,DataNasc,Salario,Email,Supervisor)
VALUES 
(1001,'Jorge Cao','1977-12-20',800.34,'jorgebunny@exc.pt',),
(1002,'Rúben Castro','1976-11-22',765.34,'josafe@osl.pt',),
(1003,'Amália Leitão','1988-08-06',800.34,'amalia@exc.pt',),
(1004,'Anabela Silva','2000-06-09',706.34,'anasilsva@cls.pt',),
(1005,'Felisberto Jacinto','1999-09-24',808.88,'felisjacks@yt.pt',),
(1006,'Catarina Paulina','1984-03-14',901.93,'asdasdas@boas.pt',),
(1007,'Paulo Manuel','1993-10-19',924.04,'asddddd@ola.pt',),
(1008,'Gabriela Pedrosa','1979-11-15',855.93,'kappa@kappa.pt',1001),
(1009,'Joana Cardoso','1996-12-01',994.92,'joaneta@cls.pt',1001),
(1010,'João Teixeira','1986-05-02',1000.04,'dreiacatita@boa.pt',1002);
(1011,'Tiago Ribeiro','1996-12-01',994.92,'trigaspeez@cls.pt',1003),
(1012,'Joaquina Vieira','1995-02-02',1010.04,'dromalana@boa.pt',1003);
(1013,'Manuel Veigas','1999-11-01',994.92,'jmaneze@cls.pt',1002),
(1014,'Liliana Barbosa','1999-05-02',1020.04,'baquijaza@boane.pt',1004);
(1015,'Luísa Peixoto','2000-10-11',990.92,'hutae34@clso.pt',1004),
(1016,'Bruno Restivo','2001-05-02',900.14,'jackiopasa77@bos.pt',1005);
(1017,'Paulo Pereira','2002-12-01',990.92,'jhutaera@clin.pt',1006),
(1018,'Óscar Neves','2001-01-12',1000.04,'guilada@boo.pt',1006);
(1019,'Carlos Wilson','1992-10-21',992.92,'pavono43@exc.pt',1007),
(1020,'Telma Baratas','1983-02-08',1000.04,'iuabamo21@boas.pt',1005);


CREATE TABLE LOJA (

 Nome VARCHAR(64) PRIMARY KEY NOT NULL,
 Rua VARCHAR(64) NOT NULL,
 Num INT NOT NULL,
 Andar INT DEFAULT NULL,
 Localidade VARCHAR(64) NOT NULL,
 CodPostal INT DEFAULT NULL,
 Responsavel INT NOT NULL
);

CONSTRAINT `LOJA_ibfk_1` FOREIGN KEY(`Responsavel`) REFERENCES FUNCIONARIO(`NumId`) ON UPDATE CASCADE;


INSERT INTO LOJA(Nome,Rua,Num,Andar,Localidade,CodPostal,Responsavel)
VALUES
('Law' , 'GrandLine', 235, 1 , 'New World', 4475, 1001),
('Luffy' , 'Wano' , 122, 1 , 'Red Line', 4430, 1002),
('Sanji' , 'Logue' , 202, 2 , 'Blue Line', 4270, 1003),
('Usopp' , 'Alabasta' , 132, 2 , 'ALl BLue', 4480, 1004),
('Tonny Tonny' , 'Arlong' , 432, 1 , 'West BLue', 4350, 1005),
('Robin' , 'ThrillerBark' , 332, 2 , 'South Blue', 4577, 1006),
('Zoro' , 'Zou' , 777, 1 , 'North Blue', 4235, 1007);

CREATE TABLE PRODUTO (

 NumId INT PRIMARY KEY NOT NULL,
 Nome VARCHAR(64) NOT NULL,
 Preco_Compra decimal(6,2) NOT NULL,
 Preco_Venda decimal(6,2) NOT NULL,
 Validade DATE NOT NULL,
 Fornecedor INT NOT NULL,
 Loja VARCHAR(32) NOT NULL
);

ALTER TABLE PRODUTO ADD FOREIGN KEY(Fornecedor) REFERENCES FORNECEDOR(NumId);
ALTER TABLE PRODUTO ADD FOREIGN KEY(Loja) REFERENCES LOJA(Nome);


INSERT INTO PRODUTO(NumId,Nome,Preco_Compra,Preco_Venda,Validade,Fornecedor,Loja)
VALUES
(2031,'Swashabi saquetas',6.09,6.45,'2022-05-12',4000,'Law'),
(2131,'Playmobila',17.09,20.45,'2022-05-12',4000,'Sanji'),
(2341,'SwashPotatoes',6.39,7.45,'2022-05-05',4001,'Robin'),
(2201,'Rebuçados',6.09,6.85,'2022-04-30',4002,'Law'),
(2921,'Padas',0.39,0.45,'2022-08-13',4003,'Zoro'),
(2001,'Bolomorango',1.09,1.45,'2023-11-24',4004,'Tonny Tonny'),
(2410,'Hortaliças',7.09,9.45,'2022-01-17',4005,'Luffy'),
(2192,'BiclasXPTO',30.09,35.45,'2025-05-12',4005,'Usopp'),
(2021,'Padas',30.09,35.45,'2025-05-12',4005,'Usopp');
(2476,'MesaExtreme',45.99,54.00,'2023-09-23',4003,'Law');
(2845,'VHSrecorder',89,03,90.06,'2025-04-03',4000,'Sanji');
(2189,'Dianaś film',44.20,72.69,'2024-02-12',4002,'Luffy');
(2987,'AsuLaptop',400.05,500.43,'2028-03-23',4004,'Zoro');
(2008,'PSpy5',103.05,143.06,'2029-03-12',4002,'Robin');
(2004,'CortadorarelvaPotente',45.05,54.67,'2025-05-09',4005,'Usopp');
(2254,'Xadrezinha',25.05,29.04,'2022-06-12',4001,'Tonny Tonny');

CREATE TABLE TELEMOVEL (
 
 NumId INT NOT NULL,
 Numero INT NOT NULL,
 PRIMARY KEY(NumId,Numero)
);

INSERT INTO TELEMOVEL(NumId,Numero)
VALUES
(1001,912113111),
(1002,915141112),
(1003,916161713),
(1004,911111114),
(1005,921171815),
(1006,922314116),
(1007,931416517),
(1008,912407110);
(1009,921400517),
(1010,912439118);
(1001,921416887),
(1012,912434118);
(1013,921405051),
(1014,912430028);
(1015,921203452),
(1016,912434778);
(1017,921416007),
(1018,912434698);
(1019,931469717),
(1020,962430318);

ALTER TABLE TELEMOVEL ADD FOREIGN KEY(NumId) REFERENCES FUNCIONARIO(NumId);

CREATE TABLE TRABALHA_PARA (

Funcionario INT NOT NULL,
Loja VARCHAR(64) NOT NULL,
Horas INT NOT NULL,
PRIMARY KEY(Funcionario,Loja)
);

ALTER TABLE TRABALHA_PARA ADD FOREIGN KEY(Funcionario) REFERENCES FUNCIONARIO(NumId);
ALTER TABLE TRABALHA_PARA ADD FOREIGN KEY(Loja) REFERENCES LOJA(Nome);

INSERT INTO TRABALHA_PARA(Funcionario,Loja,Horas)
VALUES
(1001, 'Law', 8),
(1002, 'Usopp', 7),
(1003, 'Luffy', 8),
(1004, 'Robin', 6),
(1005, 'Tonny Tonny', 5),
(1006, 'Sanji', 5),
(1007, 'Zoro', 4),
(1008, 'Law', 8),
(1009, 'Law' , 8),
(1010 ,'Luffy', 8);
(1011 ,'Sanji', 5);
(1012 ,'Sanji', 5);
(1013 ,'Luffy', 8);
(1014 ,'Usopp', 7);
(1015 ,'Usopp', 7);
(1016 ,'Tonny Tonny', 5);
(1017,'Robin', 6);
(1018,'Robin', 6);
(1019,'Zoro', 4);
(1020 ,'Tonny Tonny', 5);


CREATE TABLE CATEGORIA (

NumId INT PRIMARY KEY NOT NULL,
NomeCategoria VARCHAR(64) NOT NULL
);

INSERT INTO CATEGORIA(NumId,NomeCategoria)
VALUES
(1,'Outros'),
(2,'Brinquedos'),
(3,'Entretenimento'),
(4,'Doces'),
(5,'Padaria'),
(6,'Legumes'),
(7,'Pastelaria');
(8,'Desporto');
(9,'Tecnologia');
(10,'Mobiliário');
(11,'Jardinagem');
(12,'Recordações');

CREATE TABLE PRODUTO_CATEGORIA (

NumId INT PRIMARY KEY NOT NULL,
CategoriaId INT NOT NULL,
KEY CategoriaId(CategoriaId)
);

ALTER TABLE PRODUTO_CATEGORIA ADD FOREIGN KEY(NumId) REFERENCES PRODUTO(NumId);
ALTER TABLE PRODUTO_CATEGORIA ADD FOREIGN KEY(CategoriaId) REFERENCES CATEGORIA(NumId);

INSERT INTO PRODUTO_CATEGORIA(NumId,CategoriaId)
VALUES
(2031,1),
(2131,2),
(2341,6),
(2201,4),
(2921,5),
(2001,7),
(2410,6),
(2192,8),
(2021,5);
(2476,10);
(2845,12);
(2189,12);
(2987,9);
(2008,9);
(2004,11);
(2254,3);


