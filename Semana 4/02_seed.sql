BEGIN;

INSERT INTO aluno (nome, cpf, data_nascimento, telefone, email, data_cadastro) VALUES
('Ana Souza', '11111111111', '2000-04-15', '98901-0101', 'ana.souza@email.com', '2026-08-01 09:00:00-03'),
('Bruno Lima', '22222222222', '1998-09-22', '98902-0202', 'bruno.lima@email.com', '2026-08-05 09:00:00-03'),
('Carla Mendes', '33333333333', '2001-01-30', '98903-0303', 'carla.mendes@email.com', '2026-08-10 09:00:00-03');

INSERT INTO instrutor (nome, cpf, especialidade, telefone, email, data_contratacao) VALUES
('Diego Alves', '44444444444', 'Musculacao', '98904-0404', 'diego.alves@academia.com', '2024-02-01'),
('Elisa Rocha', '55555555555', 'Pilates', '98905-0505', 'elisa.rocha@academia.com', '2024-03-15'),
('Fabio Costa', '66666666666', 'Funcional', '98906-0606', 'fabio.costa@academia.com', '2024-05-20');

INSERT INTO plano (nome) VALUES ('Mensal'), ('Trimestral'), ('Anual');

INSERT INTO assinatura (id_aluno, id_plano, data_inicio, data_fim, status, forma_pagamento) VALUES
(1, 1, '2026-08-01', '2026-08-31', 'INATIVA', 'PIX'),
(2, 2, '2026-08-05', '2026-11-05', 'ATIVA', 'CARTAO'),
(3, 3, '2026-08-10', '2027-08-10', 'ATIVA', 'BOLETO');

INSERT INTO aula (id_instrutor) VALUES (1), (2), (3);
INSERT INTO participa (id_aluno, id_aula) VALUES (1, 1), (2, 2), (3, 3);

COMMIT;
