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
(4000 , 'GrandLine' ),
(4001 , 'Wano' ),
(4002 , 'Logue'),
(4003 , 'Alabasta'),
(4004 , 'Arlong'),
(4005 , 'ThrillerBark'),
(4006 , 'Zou');


CREATE TABLE FUNCIONARIO (

 NumId INT PRIMARY KEY AUTO_INCREMENT,
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
(1,'Jorge Coelho','1977-12-20',800.34,'jorgebunny@exc.pt',2),
(2,'Rúben Castro','1976-11-22',765.34,'josafe@osl.pt',3),
(3,'Amália Leitão','1988-08-06',800.34,'amalia@exc.pt',4),
(4,'Anabela Silva','2000-06-09',706.34,'anasilsva@cls.pt',5),
(5,'Felisberto Jacinto','1999-09-24',808.88,'felisjacks@yt.pt',1),
(6,'Catarina Paulina','1984-03-14',901.93,'asdasdas@boas.pt',6),
(7,'Paulo Manuel','1993-10-19',924.04,'asddddd@ola.pt',7),
(8,'Gabriela Pedrosa','1979-11-15',855.93,'kappa@kappa.pt',1),
(9,'Joana Cardoso','1996-12-01',994.92,'joaneta@cls.pt',9),
(10,'Onésimo Teixeira','1986-05-02',1000.04,'dreiacatita@boas.pt',5);

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
('Law' , 'GrandLine', 235, 1 , 'New World', 4475, 1),
('Luffy' , 'Wano' , 122, 1 , 'Red Line', 4430, 2),
('Sanji' , 'Logue' , 202, 2 , 'Blue Line', 4270, 5),
('Usopp' , 'Alabasta' , 132, 2 , 'ALl BLue', 4480, 4),
('Tonny Tonny' , 'Arlong' , 432, 1 , 'West BLue', 4350, 6),
('Robin' , 'ThrillerBark' , 332, 2 , 'South Blue', 4577, 8),
('Zoro' , 'Zou' , 777, 1 , 'North Blue', 4235, 7);

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
(2001,'Baguetes',1.09,1.45,'2023-11-24',4004,'Tonny Tonny'),
(2410,'Hortaliças',7.09,9.45,'2022-01-17',4005,'Luffy'),
(2192,'BiclasXPTO',30.09,35.45,'2025-05-12',4005,'Usopp');

CREATE TABLE TELEMOVEL (
 
 NumId INT NOT NULL,
 Numero INT NOT NULL,
 PRIMARY KEY(NumId,Numero)
);

INSERT INTO TELEMOVEL(NumId,Numero)
VALUES
(1,912113111),
(2,915141112),
(3,916161713),
(4,911111114),
(5,921171815),
(6,922314116),
(7,931416517),
(8,912497118);



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
(1, 'Law', 8),
(2, 'Usopp', 7),
(3, 'Luffy', 8),
(4, 'Robin', 6),
(5, 'Tonny Tonny', 5),
(6, 'Sanji', 6),
(7, 'Zoro', 4),
(8, 'Law', 6),
(9, 'Zoro' , 8),
(10 ,'Luffy', 7);


CREATE TABLE CATEGORIA (

NumId INT PRIMARY KEY NOT NULL,
NomeCategoria VARCHAR(64) NOT NULL
);

ALTER TABLE CATEGORIA ADD FOREIGN KEY(NumId) REFERENCES PRODUTO(NumId);

INSERT INTO CATEGORIA(NumId,NomeCategoria)
VALUES
(2031,'Outros'),
(2131,'Brinquedos'),
(2341,'Outros'),
(2201,'Doces'),
(2921,'Padaria'),
(2410,'Legumes'),
(2001,'Padaria'),
(2192,'Desporto');


