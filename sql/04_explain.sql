ANALYZE aluno;
ANALYZE plano;
ANALYZE assinatura;
ANALYZE participa;
ANALYZE aula;
ANALYZE instrutor;

-- Consulta 1: percorre FKs de assinatura e PKs de aluno/plano.
EXPLAIN (ANALYZE, BUFFERS)
SELECT a.nome AS aluno, p.nome AS plano, ass.data_inicio, ass.data_fim, ass.status
FROM assinatura AS ass
JOIN aluno AS a ON a.id_aluno = ass.id_aluno
JOIN plano AS p ON p.id_plano = ass.id_plano;

-- Consulta 2: associação aluno-aula e instrutor; verifica idx_participa_id_aula.
EXPLAIN (ANALYZE, BUFFERS)
SELECT a.nome AS aluno, au.id_aula, i.nome AS instrutor, i.especialidade
FROM participa AS pa
JOIN aluno AS a ON a.id_aluno = pa.id_aluno
JOIN aula AS au ON au.id_aula = pa.id_aula
JOIN instrutor AS i ON i.id_instrutor = au.id_instrutor;
