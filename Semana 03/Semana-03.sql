-- Semana 03 - Modelo Logico Estruturado (3FN)

CREATE DATABASE IF NOT EXISTS academia_semana_03;
USE academia_semana_03;

CREATE TABLE aluno (
    id_aluno INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    data_cadastro DATE NOT NULL DEFAULT (CURRENT_DATE),
    CONSTRAINT ck_aluno_email CHECK (email LIKE '%@%.%')
);

CREATE TABLE instrutor (
    id_instrutor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    especialidade VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    data_contratacao DATE NOT NULL DEFAULT (CURRENT_DATE),
    CONSTRAINT ck_instrutor_email CHECK (email LIKE '%@%.%')
);

CREATE TABLE plano (
    id_plano INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE assinatura (
    id_assinatura INT AUTO_INCREMENT PRIMARY KEY,
    id_aluno INT NOT NULL,
    id_plano INT NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NULL,
    status ENUM('ATIVA', 'INATIVA', 'CANCELADA') NOT NULL DEFAULT 'ATIVA',
    forma_pagamento ENUM('CARTAO', 'PIX', 'DINHEIRO', 'BOLETO') NOT NULL,
    CONSTRAINT ck_assinatura_periodo CHECK (
        data_fim IS NULL OR data_fim >= data_inicio
    ),
    CONSTRAINT fk_assinatura_aluno
        FOREIGN KEY (id_aluno) REFERENCES aluno (id_aluno),
    CONSTRAINT fk_assinatura_plano
        FOREIGN KEY (id_plano) REFERENCES plano (id_plano)
);

CREATE TABLE aula (
    id_aula INT AUTO_INCREMENT PRIMARY KEY,
    id_instrutor INT NOT NULL,
    CONSTRAINT fk_aula_instrutor
        FOREIGN KEY (id_instrutor) REFERENCES instrutor (id_instrutor)
);

CREATE TABLE participa (
    id_aluno INT NOT NULL,
    id_aula INT NOT NULL,
    PRIMARY KEY (id_aluno, id_aula),
    CONSTRAINT fk_participa_aluno
        FOREIGN KEY (id_aluno) REFERENCES aluno (id_aluno),
    CONSTRAINT fk_participa_aula
        FOREIGN KEY (id_aula) REFERENCES aula (id_aula)
);

-- Dados de teste: 3 registros por tabela.
INSERT INTO aluno (nome, cpf, data_nascimento, telefone, email, data_cadastro) VALUES
    ('Ana Souza', '11111111111', '2000-04-15', '98901-0101', 'ana.souza@email.com', '2026-08-01'),
    ('Bruno Lima', '22222222222', '1998-09-22', '98902-0202', 'bruno.lima@email.com', '2026-08-05'),
    ('Carla Mendes', '33333333333', '2001-01-30', '98903-0303', 'carla.mendes@email.com', '2026-08-10');

INSERT INTO instrutor (nome, cpf, especialidade, telefone, email, data_contratacao) VALUES
    ('Diego Alves', '44444444444', 'Musculacao', '98904-0404', 'diego.alves@academia.com', '2024-02-01'),
    ('Elisa Rocha', '55555555555', 'Pilates', '98905-0505', 'elisa.rocha@academia.com', '2024-03-15'),
    ('Fabio Costa', '66666666666', 'Funcional', '98906-0606', 'fabio.costa@academia.com', '2024-05-20');

INSERT INTO plano (nome) VALUES
    ('Mensal'),
    ('Trimestral'),
    ('Anual');

INSERT INTO assinatura (id_aluno, id_plano, data_inicio, data_fim, status, forma_pagamento) VALUES
    (1, 1, '2026-08-01', '2026-08-31', 'INATIVA', 'PIX'),
    (2, 2, '2026-08-05', '2026-11-05', 'ATIVA', 'CARTAO'),
    (3, 3, '2026-08-10', '2027-08-10', 'ATIVA', 'BOLETO');

INSERT INTO aula (id_instrutor) VALUES
    (1),
    (2),
    (3);

INSERT INTO participa (id_aluno, id_aula) VALUES
    (1, 1),
    (2, 2),
    (3, 3);

-- Consulta 1: alunos, seus planos e o estado da assinatura.
SELECT
    a.nome AS aluno,
    p.nome AS plano,
    ass.data_inicio,
    ass.data_fim,
    ass.status
FROM assinatura AS ass
JOIN aluno AS a ON a.id_aluno = ass.id_aluno
JOIN plano AS p ON p.id_plano = ass.id_plano;

-- Consulta 2: alunos matriculados em aulas e seus instrutores.
SELECT
    a.nome AS aluno,
    au.id_aula,
    i.nome AS instrutor,
    i.especialidade
FROM participa AS pa
JOIN aluno AS a ON a.id_aluno = pa.id_aluno
JOIN aula AS au ON au.id_aula = pa.id_aula
JOIN instrutor AS i ON i.id_instrutor = au.id_instrutor;
