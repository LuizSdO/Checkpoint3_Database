/*
DROP TABLE ALUNO CASCADE CONSTRAINTS;
DROP TABLE Disciplina CASCADE CONSTRAINTS;
DROP TABLE PROFESSOR CASCADE CONSTRAINTS;
DROP TABLE Turma CASCADE CONSTRAINTS;
DROP TABLE Historico CASCADE CONSTRAINTS;
*/



create table Aluno(
    ra number(4) primary key,
    nome varchar(25) not null,
    endereco varchar(30) not null,
    cidade varchar(25)
);

create table Disciplina(
    cod_disc number(4) primary key,
    nome_disc varchar(30) not null,
    carga_hor number(4) not null 
);
ALTER TABLE Disciplina ADD CONSTRAINT un_disc UNIQUE ( carga_hor );


create table Professor(
    cod_prof number(4) primary key,
    nome_prof varchar(25) not null, 
    endereco varchar(30) not null, 
    cidade varchar(25) 
);


create table Turma(
    cod_disc references Disciplina,
    cod_turma number(4) primary key,
    cod_prof references Professor,
    ano number(4) not null, 
    periodo varchar(20) not null
);


create table Historico(
    ra references Aluno,
    cod_disc references Disciplina,
    cod_turma references Turma,
    cod_prof references Professor,
    ano number(4) not null,
    faltas number(3),
    nota1 number(4,2),
    nota2 number(4,2),
    situacao varchar(25) 
);





-- Inser��o de dados na tabela Aluno
INSERT INTO Aluno (RA, Nome, Endereco, Cidade) VALUES (1, 'Jo�o', 'Rua Jose', 'Cidade A');
INSERT INTO Aluno (RA, Nome, Endereco, Cidade) VALUES (2, 'Maria', 'Rua Paulista', 'Cidade B');
INSERT INTO Aluno (RA, Nome, Endereco, Cidade) VALUES (3, 'Pedro', 'Rua Br�s', 'Cidade C');
INSERT INTO Aluno (RA, Nome, Endereco, Cidade) VALUES (4, 'Ana', 'Rua Lins', 'Cidade D');
INSERT INTO Aluno (RA, Nome, Endereco, Cidade) VALUES (5, 'Carlos', 'Rua Villa', 'Cidade E');

�

-- Inser��o de dados na tabela Disciplina
INSERT INTO Disciplina (COD_DISC, Nome_disc, Carga_hor) VALUES (1, 'Matem�tica', 60);
INSERT INTO Disciplina (COD_DISC, Nome_disc, Carga_hor) VALUES (2, 'Hist�ria', 40);
INSERT INTO Disciplina (COD_DISC, Nome_disc, Carga_hor) VALUES (3, 'Geografia', 50);
INSERT INTO Disciplina (COD_DISC, Nome_disc, Carga_hor) VALUES (4, 'Ci�ncias', 45);
INSERT INTO Disciplina (COD_DISC, Nome_disc, Carga_hor) VALUES (5, 'Portugu�s', 55);

�

-- Inser��o de dados na tabela Professor
INSERT INTO Professor (COD_PROF, Nome_Prof, Endereco, Cidade) VALUES (1, 'Prof. Silva', 'Rua C', 'Cidade X');
INSERT INTO Professor (COD_PROF, Nome_Prof, Endereco, Cidade) VALUES (2, 'Prof. Santos', 'Rua D', 'Cidade Y');
INSERT INTO Professor (COD_PROF, Nome_Prof, Endereco, Cidade) VALUES (3, 'Prof. Oliveira', 'Rua Y', 'Cidade Z');
INSERT INTO Professor (COD_PROF, Nome_Prof, Endereco, Cidade) VALUES (4, 'Prof. Souza', 'Rua T', 'Cidade W');
INSERT INTO Professor (COD_PROF, Nome_Prof, Endereco, Cidade) VALUES (5, 'Prof. Almeida', 'Rua Q', 'Cidade V');

�

-- Inser��o de dados na tabela Turma
INSERT INTO Turma (COD_DISC, COD_TURMA, COD_PROF, ANO, Periodo) VALUES (1, 1, 1, 2023, 'Primeiro Semestre');
INSERT INTO Turma (COD_DISC, COD_TURMA, COD_PROF, ANO, Periodo) VALUES (2, 2, 2, 2023, 'Segundo Semestre');
INSERT INTO Turma (COD_DISC, COD_TURMA, COD_PROF, ANO, Periodo) VALUES (3, 3, 3, 2023, 'Terceiro Semestre');