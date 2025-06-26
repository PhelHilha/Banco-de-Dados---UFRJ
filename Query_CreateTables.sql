-- Script SQL Server atualizado com chaves estrangeiras

USE master;
GO

-- Forçar desconexão e apagar o banco se existir
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'VacinaDB')
BEGIN
    ALTER DATABASE VacinaDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE VacinaDB;
END
GO

CREATE DATABASE VacinaDB;
GO
USE VacinaDB;
GO

-- Tabelas

CREATE TABLE Sexo (
  ID_Sexo INT IDENTITY PRIMARY KEY,
  Descricao VARCHAR(50) NOT NULL
);

CREATE TABLE Estado_Civil (
  ID_Estado_Civil INT IDENTITY PRIMARY KEY,
  Descricao VARCHAR(50) NOT NULL
);

CREATE TABLE Pais (
  ID_Pais INT IDENTITY PRIMARY KEY,
  Nome VARCHAR(100) NOT NULL
);

CREATE TABLE Nacionalidade (
  ID_Nacionalidade INT IDENTITY PRIMARY KEY,
  Nome VARCHAR(100) NOT NULL,
  ID_Pais INT NOT NULL,
  FOREIGN KEY (ID_Pais) REFERENCES Pais(ID_Pais)
);

CREATE TABLE Estado (
  ID_Estado INT IDENTITY PRIMARY KEY,
  Nome VARCHAR(100) NOT NULL,
  Sigla VARCHAR(5) NOT NULL,
  ID_Pais INT NOT NULL,
  FOREIGN KEY (ID_Pais) REFERENCES Pais(ID_Pais)
);

CREATE TABLE Cidade (
  ID_Cidade INT IDENTITY PRIMARY KEY,
  Nome VARCHAR(100) NOT NULL,
  ID_Estado INT NOT NULL,
  FOREIGN KEY (ID_Estado) REFERENCES Estado(ID_Estado)
);

CREATE TABLE Bairro (
  ID_Bairro INT IDENTITY PRIMARY KEY,
  Nome VARCHAR(100) NOT NULL,
  ID_Cidade INT NOT NULL,
  FOREIGN KEY (ID_Cidade) REFERENCES Cidade(ID_Cidade)
);

CREATE TABLE Logradouro (
  ID_Logradouro INT IDENTITY PRIMARY KEY,
  Nome VARCHAR(100) NOT NULL,
  CEP VARCHAR(10) NOT NULL,
  ID_Bairro INT NOT NULL,
  FOREIGN KEY (ID_Bairro) REFERENCES Bairro(ID_Bairro)
);

CREATE TABLE Complemento (
  ID_Complemento INT IDENTITY PRIMARY KEY,
  Descricao VARCHAR(100)
);

CREATE TABLE Endereco (
  ID_Endereco INT IDENTITY PRIMARY KEY,
  Numero VARCHAR(10) NOT NULL,
  ID_Logradouro INT NOT NULL,
  ID_Complemento INT NULL,
  FOREIGN KEY (ID_Logradouro) REFERENCES Logradouro(ID_Logradouro),
  FOREIGN KEY (ID_Complemento) REFERENCES Complemento(ID_Complemento)
);

CREATE TABLE Pessoa_Fisica (
  ID_Pessoa_Fisica INT IDENTITY PRIMARY KEY,
  Nome VARCHAR(100) NOT NULL,
  Data_Nascimento DATE NOT NULL,
  RG VARCHAR(20) UNIQUE NOT NULL,
  ID_Sexo INT NOT NULL,
  ID_Estado_Civil INT NOT NULL,
  ID_Nacionalidade INT NOT NULL,
  FOREIGN KEY (ID_Sexo) REFERENCES Sexo(ID_Sexo),
  FOREIGN KEY (ID_Estado_Civil) REFERENCES Estado_Civil(ID_Estado_Civil),
  FOREIGN KEY (ID_Nacionalidade) REFERENCES Nacionalidade(ID_Nacionalidade)
);

CREATE TABLE Pessoa_Juridica (
  ID_Pessoa_Juridica INT IDENTITY PRIMARY KEY,
  Nome VARCHAR(100) NOT NULL,
  Contato VARCHAR(100)
);

CREATE TABLE Vacinador (
  ID_Vacinador INT IDENTITY PRIMARY KEY,
  ID_Pessoa_Fisica INT NOT NULL,
  FOREIGN KEY (ID_Pessoa_Fisica) REFERENCES Pessoa_Fisica(ID_Pessoa_Fisica)
);

CREATE TABLE Genero (
  ID_Genero INT IDENTITY PRIMARY KEY,
  Descricao VARCHAR(50) NOT NULL
);

CREATE TABLE Pessoa_Genero (
  ID_Pessoa_Fisica INT NOT NULL,
  ID_Genero INT NOT NULL,
  PRIMARY KEY (ID_Pessoa_Fisica, ID_Genero),
  FOREIGN KEY (ID_Pessoa_Fisica) REFERENCES Pessoa_Fisica(ID_Pessoa_Fisica),
  FOREIGN KEY (ID_Genero) REFERENCES Genero(ID_Genero)
);

CREATE TABLE Telefone (
  ID_Telefone INT IDENTITY PRIMARY KEY,
  Numero VARCHAR(20) NOT NULL
);

CREATE TABLE Tipo_Telefone (
  ID_Tipo_Telefone INT IDENTITY PRIMARY KEY,
  Descricao VARCHAR(50) NOT NULL
);

CREATE TABLE Contato_Telefone (
  ID_Contato INT IDENTITY PRIMARY KEY,
  ID_Pessoa_Fisica INT NOT NULL,
  ID_Tipo_Telefone INT NOT NULL,
  ID_Telefone INT NOT NULL,
  FOREIGN KEY (ID_Pessoa_Fisica) REFERENCES Pessoa_Fisica(ID_Pessoa_Fisica),
  FOREIGN KEY (ID_Tipo_Telefone) REFERENCES Tipo_Telefone(ID_Tipo_Telefone),
  FOREIGN KEY (ID_Telefone) REFERENCES Telefone(ID_Telefone)
);

CREATE TABLE Residencia (
  ID_Residencia INT IDENTITY PRIMARY KEY,
  ID_Pessoa_Fisica INT NOT NULL,
  ID_Endereco INT NOT NULL,
  ID_Pessoa_Juridica INT NULL,
  Principal BIT NOT NULL DEFAULT 1,
  FOREIGN KEY (ID_Pessoa_Fisica) REFERENCES Pessoa_Fisica(ID_Pessoa_Fisica),
  FOREIGN KEY (ID_Endereco) REFERENCES Endereco(ID_Endereco),
  FOREIGN KEY (ID_Pessoa_Juridica) REFERENCES Pessoa_Juridica(ID_Pessoa_Juridica)
);

CREATE TABLE Doenca (
  ID_Doenca INT IDENTITY PRIMARY KEY,
  Nome VARCHAR(100) NOT NULL
);

CREATE TABLE Fabricante (
    ID_Pessoa_Juridica INT PRIMARY KEY,
    ID_Pais_Origem INT NULL,
    FOREIGN KEY (ID_Pessoa_Juridica) REFERENCES Pessoa_Juridica(ID_Pessoa_Juridica),
    FOREIGN KEY (ID_Pais_Origem) REFERENCES Pais(ID_Pais)
);

CREATE TABLE Vacina (
  ID_Vacina INT IDENTITY PRIMARY KEY,
  Nome VARCHAR(100) NOT NULL,
  Doses INT NOT NULL,
  ID_Fabricante INT NULL,
  FOREIGN KEY (ID_Fabricante) REFERENCES Fabricante(ID_Pessoa_Juridica)
);

CREATE TABLE Protege_Contra (
  ID_Vacina INT NOT NULL,
  ID_Doenca INT NOT NULL,
  PRIMARY KEY (ID_Vacina, ID_Doenca),
  FOREIGN KEY (ID_Vacina) REFERENCES Vacina(ID_Vacina),
  FOREIGN KEY (ID_Doenca) REFERENCES Doenca(ID_Doenca)
);

CREATE TABLE Lote (
  ID_Lote INT IDENTITY PRIMARY KEY,
  Codigo VARCHAR(50) NOT NULL,
  Data_Fabricacao DATE NOT NULL,
  Data_Validade DATE NOT NULL,
  ID_Vacina INT NOT NULL,
  Quantidade INT NOT NULL,
  FOREIGN KEY (ID_Vacina) REFERENCES Vacina(ID_Vacina)
);

CREATE TABLE Unidade_Saude (
  ID_Unidade INT IDENTITY PRIMARY KEY,
  ID_Pessoa_Juridica INT NULL,
  ID_Endereco INT NOT NULL,
  FOREIGN KEY (ID_Pessoa_Juridica) REFERENCES Pessoa_Juridica(ID_Pessoa_Juridica),
  FOREIGN KEY (ID_Endereco) REFERENCES Endereco(ID_Endereco)
);

CREATE TABLE Aplicacao (
  ID_Aplicacao INT IDENTITY PRIMARY KEY,
  Data_Aplicacao DATE NOT NULL,
  Dose VARCHAR(20) NOT NULL,
  ID_Pessoa_Fisica INT NOT NULL,
  ID_Vacinador INT NOT NULL,
  ID_Unidade INT NOT NULL,
  ID_Lote INT NOT NULL,
  FOREIGN KEY (ID_Pessoa_Fisica) REFERENCES Pessoa_Fisica(ID_Pessoa_Fisica),
  FOREIGN KEY (ID_Vacinador) REFERENCES Vacinador(ID_Vacinador),
  FOREIGN KEY (ID_Unidade) REFERENCES Unidade_Saude(ID_Unidade),
  FOREIGN KEY (ID_Lote) REFERENCES Lote(ID_Lote)
);

CREATE TABLE Vacinador_Unidade (
  ID_Vacinador INT NOT NULL,
  ID_Unidade INT NOT NULL,
  PRIMARY KEY (ID_Vacinador, ID_Unidade),
  FOREIGN KEY (ID_Vacinador) REFERENCES Vacinador(ID_Vacinador),
  FOREIGN KEY (ID_Unidade) REFERENCES Unidade_Saude(ID_Unidade)
);
