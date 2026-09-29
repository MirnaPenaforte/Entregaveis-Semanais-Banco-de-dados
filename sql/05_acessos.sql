-- Executar como administrador. Ajuste senhas e nomes conforme a instalação.
BEGIN;

CREATE ROLE academia_leitura NOLOGIN;
CREATE USER academia_consulta WITH LOGIN PASSWORD 'Troque_Esta_Senha_Consulta_2026';
GRANT academia_leitura TO academia_consulta;

CREATE USER academia_operacao WITH LOGIN PASSWORD 'Troque_Esta_Senha_Operacao_2026';

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM PUBLIC;
GRANT USAGE ON SCHEMA public TO academia_leitura, academia_operacao;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO academia_leitura;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO academia_operacao;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO academia_operacao;

-- A role de leitura não herda escrita; operação recebe escrita apenas nas
-- tabelas atuais. Execute ALTER DEFAULT PRIVILEGES como o dono das tabelas
-- para configurar objetos futuros.
COMMIT;
