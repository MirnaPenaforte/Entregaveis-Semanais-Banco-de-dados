CREATE TABLE ALUNO (
    id_aluno INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(20) UNIQUE,
    data_cadastro DATE,
    telefone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    data_nascimento DATE
);

CREATE TABLE INSTRUTOR (
    id_instrutor INT PRIMARY KEY,
    cpf VARCHAR(20) UNIQUE,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    data_contratacao DATE,
    especialidade VARCHAR(100)
);

CREATE TABLE PLANO (
    id_plano INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE ASSINATURA (
    id_assinatura INT PRIMARY KEY,
    id_aluno INT NOT NULL,
    id_plano INT NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    status BOOLEAN,
    forma_pagamento VARCHAR(50),

    FOREIGN KEY (id_aluno) REFERENCES ALUNO(id_aluno),
    FOREIGN KEY (id_plano) REFERENCES PLANO(id_plano)
);

CREATE TABLE AULA (
    id_aula INT PRIMARY KEY,
    id_instrutor INT NOT NULL,

    FOREIGN KEY (id_instrutor)
        REFERENCES INSTRUTOR(id_instrutor)
);

CREATE TABLE PARTICIPA (
    id_aluno INT,
    id_aula INT,

    PRIMARY KEY (id_aluno, id_aula),

    FOREIGN KEY (id_aluno)
        REFERENCES ALUNO(id_aluno),

    FOREIGN KEY (id_aula)
        REFERENCES AULA(id_aula)
);