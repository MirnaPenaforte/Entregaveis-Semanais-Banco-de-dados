-- Transação 1: cadastrar aluno, assinatura e primeira aula, de forma atômica.
BEGIN;
INSERT INTO aluno (nome, cpf, data_nascimento, telefone, email)
VALUES ('Marina Costa', '77777777777', '1999-06-12', '98907-0707', 'marina.costa@email.com')
RETURNING id_aluno \gset t1_

SAVEPOINT aluno_criado;
INSERT INTO assinatura (id_aluno, id_plano, data_inicio, status, forma_pagamento)
VALUES (:t1_id_aluno, 1, CURRENT_DATE, 'ATIVA', 'PIX')
RETURNING id_assinatura;

INSERT INTO aula (id_instrutor) VALUES (1) RETURNING id_aula \gset t1_
INSERT INTO participa (id_aluno, id_aula) VALUES (:t1_id_aluno, :t1_id_aula);
COMMIT;
-- Para demonstrar reversão em vez de confirmar: troque COMMIT por
-- ROLLBACK TO SAVEPOINT aluno_criado; ROLLBACK; (todo o conjunto é desfeito).

-- Transação 2: outro cadastro relacionado. Requer que a transação 1 tenha sido
-- confirmada (ou ajuste os dados/IDs em uma execução separada).
BEGIN;
INSERT INTO aluno (nome, cpf, data_nascimento, telefone, email)
VALUES ('Rafael Nunes', '88888888888', '1997-11-03', '98908-0808', 'rafael.nunes@email.com')
RETURNING id_aluno \gset t2_

SAVEPOINT aluno_t2_criado;
INSERT INTO assinatura (id_aluno, id_plano, data_inicio, status, forma_pagamento)
VALUES (:t2_id_aluno, 2, CURRENT_DATE, 'ATIVA', 'CARTAO')
RETURNING id_assinatura;

INSERT INTO aula (id_instrutor) VALUES (2) RETURNING id_aula \gset t2_
INSERT INTO participa (id_aluno, id_aula) VALUES (:t2_id_aluno, :t2_id_aula);
COMMIT;
-- Alternativa de teste: ROLLBACK TO SAVEPOINT aluno_t2_criado; ROLLBACK;
