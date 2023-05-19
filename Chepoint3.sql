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
    media number(4,2),
    situacao varchar(25) 
    
);
commit;




-- Inserção de dados na tabela Aluno
INSERT INTO Aluno (RA, Nome, Endereco, Cidade) VALUES (1, 'João', 'Rua Jose', 'Cidade A');
INSERT INTO Aluno (RA, Nome, Endereco, Cidade) VALUES (2, 'Maria', 'Rua Paulista', 'Cidade B');
INSERT INTO Aluno (RA, Nome, Endereco, Cidade) VALUES (3, 'Pedro', 'Rua Brás', 'Cidade C');
INSERT INTO Aluno (RA, Nome, Endereco, Cidade) VALUES (4, 'Ana', 'Rua Lins', 'Cidade D');
INSERT INTO Aluno (RA, Nome, Endereco, Cidade) VALUES (5, 'Carlos', 'Rua Villa', 'Cidade E');
--select * from Aluno;

 

-- Inserção de dados na tabela Disciplina
INSERT INTO Disciplina (COD_DISC, Nome_disc, Carga_hor) VALUES (1, 'Matemática', 60);
INSERT INTO Disciplina (COD_DISC, Nome_disc, Carga_hor) VALUES (2, 'História', 40);
INSERT INTO Disciplina (COD_DISC, Nome_disc, Carga_hor) VALUES (3, 'Geografia', 50);
INSERT INTO Disciplina (COD_DISC, Nome_disc, Carga_hor) VALUES (4, 'Ciências', 45);
INSERT INTO Disciplina (COD_DISC, Nome_disc, Carga_hor) VALUES (5, 'Português', 55);
--select * from Disciplina;
 

-- Inserção de dados na tabela Professor
INSERT INTO Professor (COD_PROF, Nome_Prof, Endereco, Cidade) VALUES (1, 'Prof. Silva', 'Rua C', 'Cidade X');
INSERT INTO Professor (COD_PROF, Nome_Prof, Endereco, Cidade) VALUES (2, 'Prof. Santos', 'Rua D', 'Cidade Y');
INSERT INTO Professor (COD_PROF, Nome_Prof, Endereco, Cidade) VALUES (3, 'Prof. Oliveira', 'Rua Y', 'Cidade Z');
INSERT INTO Professor (COD_PROF, Nome_Prof, Endereco, Cidade) VALUES (4, 'Prof. Souza', 'Rua T', 'Cidade W');
INSERT INTO Professor (COD_PROF, Nome_Prof, Endereco, Cidade) VALUES (5, 'Prof. Almeida', 'Rua Q', 'Cidade V');
--select * from Professor;
 

-- Inserção de dados na tabela Turma
INSERT INTO Turma (COD_DISC, COD_TURMA, COD_PROF, ANO, Periodo) VALUES (1, 1, 1, 2023, 'Primeiro Semestre');
INSERT INTO Turma (COD_DISC, COD_TURMA, COD_PROF, ANO, Periodo) VALUES (2, 2, 2, 2023, 'Segundo Semestre');
INSERT INTO Turma (COD_DISC, COD_TURMA, COD_PROF, ANO, Periodo) VALUES (3, 3, 3, 2023, 'Terceiro Semestre');
--select * from Turma;




set serveroutput on
set verify off

DECLARE
  v_ra Aluno.ra%TYPE;
  v_cod_disc Historico.cod_disc%TYPE;
  v_cod_turma Historico.cod_turma%TYPE;
  v_cod_prof Historico.cod_prof%TYPE;
  v_ano Historico.ano%TYPE;
  v_faltas Historico.faltas%TYPE;
  v_nota1 Historico.nota1%TYPE;
  v_nota2 Historico.nota2%TYPE;
  v_media Historico.media%TYPE;
  v_situacao Historico.situacao%TYPE;
  
  FUNCTION calcular_situacao(media IN NUMBER) RETURN VARCHAR2 IS 
    situacao VARCHAR2(25);
  BEGIN
    IF media >= 7 THEN
      situacao := 'Aprovado';
    ELSIF media >= 5 THEN
      situacao := 'Recuperação';
    ELSE
      situacao := 'Reprovado';
    END IF;
    
    RETURN situacao;
  END;
BEGIN
  v_ra := &v_ra;
  
  BEGIN
    SELECT ra
    INTO v_ra
    FROM Aluno
    WHERE ra = v_ra;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Código inválido. Digite um código de aluno válido.');
      RETURN;
  END;
  v_cod_disc := &v_cod_disc;
  v_cod_turma := &v_cod_turma;
  v_cod_prof := &v_cod_prof;
  v_ano := &v_ano;
  
  BEGIN
    SELECT cod_disc
    INTO v_cod_disc
    FROM Disciplina
    WHERE cod_disc = v_cod_disc;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Código inválido. Digite um código de disciplina válido.');
      RETURN;
  END;
  
  BEGIN
    SELECT cod_turma
    INTO v_cod_turma
    FROM Turma
    WHERE cod_turma = v_cod_turma;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Código inválido. Digite um código de turma válido.');
      RETURN;
  END;
  
  BEGIN
    SELECT cod_prof
    INTO v_cod_prof
    FROM Professor
    WHERE cod_prof = v_cod_prof;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Código inválido. Digite um código de professor válido.');
      RETURN;
  END;
  v_faltas := &v_faltas;
  v_nota1 := &v_nota1;
  v_nota2 := &v_nota2;
  v_media := calcular_media(v_nota1, v_nota2);
  v_situacao := calcular_situacao(v_media);
  
  INSERT INTO Historico(ra, cod_disc, cod_turma, cod_prof, ano, faltas, nota1, nota2, media, situacao)
  VALUES (v_ra, v_cod_disc, v_cod_turma, v_cod_prof, v_ano, v_faltas, v_nota1, v_nota2, v_media, v_situacao);
  
  DBMS_OUTPUT.PUT_LINE('Os dados foram inseridos com sucesso!!');
END;


select * from Historico;


