# Semanas 07 e 08 — Catálogo de e-commerce com MongoDB

## Objetivo

Modelar e consultar um catálogo de produtos usando MongoDB, um banco NoSQL orientado a documentos. O cenário escolhido é uma loja fictícia de roupas. Todos os dados de exemplo são sintéticos.

## Arquivos desta entrega

- `01_modelagem_insercao.js`: seleciona `ecommerce_db`, cria a coleção `produtos` se ainda não existir e insere quatro documentos com arrays e subdocumentos.
- `02_indices_consultas.js`: cria um índice simples e um índice de texto, executa consultas de comparação, array, texto e `$elemMatch`, e demonstra o uso do índice com `explain("executionStats")`.

## Como executar

Com MongoDB local em execução e `mongosh` instalado, execute os dois scripts nesta ordem:

```bash
mongosh "mongodb://localhost:27017" "Semana 07 e 08/01_modelagem_insercao.js"
mongosh "mongodb://localhost:27017" "Semana 07 e 08/02_indices_consultas.js"
```

O script de inserção deve ser executado uma vez em uma coleção limpa. Executá-lo novamente insere novos documentos, pois cada inserção recebe um novo `_id`.

## Modelagem do documento

Cada produto tem atributos escalares (`sku`, `nome`, `descricao`, `categoria`, `preco`, `ativo`), o array `tags`, o subdocumento `fabricante` e o array de subdocumentos `variacoes`.

- **Embedding:** fabricante e variações ficam incorporados ao documento porque são informações apresentadas junto com o produto e, neste exemplo, pertencem a ele.
- **Referencing:** seria melhor para entidades independentes, compartilhadas por muitos produtos ou atualizadas com frequência — por exemplo, um fabricante cadastrado uma única vez e referenciado por vários produtos.

O array `variacoes` é pequeno e limitado às opções de um produto. Arrays que crescem sem limite, como histórico infinito de comentários, devem ser modelados com cuidado por causa do limite de 16 MB por documento e do custo de atualizações.

## Requisitos demonstrados

1. `insertMany()` insere quatro produtos; todos incluem um array e um subdocumento.
2. Índice simples `preco_1` apoia filtros por faixa de preço.
3. Índice de texto cobre `nome` e `descricao` (um índice de texto por coleção).
4. Consultas demonstram operadores de comparação, busca por elemento de array e `$text`.
5. `$elemMatch` exige que tamanho e cor sejam satisfeitos pela mesma variação.
6. A consulta de texto com `explain("executionStats")` permite verificar `totalKeysExamined` e o estágio do plano que usa o índice de texto.

Os valores de `executionStats` dependem da versão e do plano do MongoDB em execução; o script imprime a saída real, sem fixar métricas inventadas. **Verificação executada** em MongoDB 8.0.38: `insertMany()` inseriu quatro documentos; as consultas de preço, tag, texto e `$elemMatch` retornaram resultados esperados. No `explain("executionStats")` da busca por “camiseta”, o plano usou o índice `texto_nome_descricao` (`TEXT_MATCH`/`IXSCAN`), com `totalKeysExamined: 1` e `totalDocsExamined: 1`. Esses números são os desta execução e podem variar com dados/versões.
