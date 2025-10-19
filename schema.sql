-- Criação do banco de dados para o cenário de Oficina
CREATE DATABASE IF NOT EXISTS oficina;
USE oficina;

-- Tabela Cliente
CREATE TABLE Cliente (
    idCliente INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(255) NOT NULL,
    CPF VARCHAR(11) NOT NULL UNIQUE,
    Endereco VARCHAR(255),
    Telefone VARCHAR(15)
);

-- Tabela Veiculo
CREATE TABLE Veiculo (
    idVeiculo INT PRIMARY KEY AUTO_INCREMENT,
    Placa VARCHAR(8) NOT NULL UNIQUE,
    Modelo VARCHAR(50),
    Marca VARCHAR(50),
    Ano INT,
    idCliente INT,
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

-- Tabela Equipe_Mecanicos
CREATE TABLE Equipe_Mecanicos (
    idEquipe INT PRIMARY KEY AUTO_INCREMENT,
    NomeEquipe VARCHAR(100) NOT NULL
);

-- Tabela Mecanico
CREATE TABLE Mecanico (
    idMecanico INT PRIMARY KEY AUTO_INCREMENT,
    Codigo VARCHAR(20) NOT NULL UNIQUE,
    Nome VARCHAR(255) NOT NULL,
    Endereco VARCHAR(255),
    Especialidade VARCHAR(100),
    idEquipe INT,
    FOREIGN KEY (idEquipe) REFERENCES Equipe_Mecanicos(idEquipe)
);

-- Tabela Ordem_Servico
CREATE TABLE Ordem_Servico (
    idOS INT PRIMARY KEY AUTO_INCREMENT,
    Numero VARCHAR(50) NOT NULL UNIQUE,
    DataEmissao DATE NOT NULL,
    DataConclusao DATE,
    ValorTotal DECIMAL(10, 2),
    Status VARCHAR(50) NOT NULL,
    idVeiculo INT,
    idEquipe INT,
    FOREIGN KEY (idVeiculo) REFERENCES Veiculo(idVeiculo),
    FOREIGN KEY (idEquipe) REFERENCES Equipe_Mecanicos(idEquipe)
);

-- Tabela Servico
CREATE TABLE Servico (
    idServico INT PRIMARY KEY AUTO_INCREMENT,
    Descricao VARCHAR(255) NOT NULL,
    ValorMaoDeObra DECIMAL(10, 2) NOT NULL
);

-- Tabela Peca
CREATE TABLE Peca (
    idPeca INT PRIMARY KEY AUTO_INCREMENT,
    NomePeca VARCHAR(100) NOT NULL,
    ValorUnitario DECIMAL(10, 2) NOT NULL
);

-- Tabela Associativa OS_Servicos
CREATE TABLE OS_Servicos (
    idOS INT,
    idServico INT,
    PRIMARY KEY (idOS, idServico),
    FOREIGN KEY (idOS) REFERENCES Ordem_Servico(idOS),
    FOREIGN KEY (idServico) REFERENCES Servico(idServico)
);

-- Tabela Associativa OS_Pecas
CREATE TABLE OS_Pecas (
    idOS INT,
    idPeca INT,
    Quantidade INT NOT NULL DEFAULT 1,
    PRIMARY KEY (idOS, idPeca),
    FOREIGN KEY (idOS) REFERENCES Ordem_Servico(idOS),
    FOREIGN KEY (idPeca) REFERENCES Peca(idPeca)
);