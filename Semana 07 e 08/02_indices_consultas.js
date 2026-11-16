// Semanas 07 e 08 — índices e consultas do catálogo

const ecommerce = db.getSiblingDB("ecommerce_db");

// Índice simples para filtros por faixa de preço.
ecommerce.produtos.createIndex(
  { preco: 1 },
  { name: "preco_1" }
);

// MongoDB permite apenas um índice de texto por coleção.
ecommerce.produtos.createIndex(
  { nome: "text", descricao: "text" },
  { name: "texto_nome_descricao", default_language: "portuguese" }
);

print("1) Comparação: produtos com preço entre 80 e 180 (limite superior exclusivo)");
ecommerce.produtos.find(
  { preco: { $gte: 80, $lt: 180 } },
  { _id: 0, sku: 1, nome: 1, preco: 1 }
).sort({ preco: 1 }).forEach(printjson);

print("2) Array: produtos marcados com a tag promocao");
ecommerce.produtos.find(
  { tags: "promocao" },
  { _id: 0, sku: 1, nome: 1, tags: 1 }
).forEach(printjson);

print("3) Texto: busca por camiseta no nome ou na descricao");
ecommerce.produtos.find(
  { $text: { $search: "camiseta" } },
  { _id: 0, sku: 1, nome: 1, descricao: 1, score: { $meta: "textScore" } }
).sort({ score: { $meta: "textScore" } }).forEach(printjson);

print("4) $elemMatch: a mesma variacao deve ser tamanho M e cor Azul");
ecommerce.produtos.find(
  { variacoes: { $elemMatch: { tamanho: "M", cor: "Azul" } } },
  { _id: 0, sku: 1, nome: 1, variacoes: 1 }
).forEach(printjson);

print("5) Bonus: estatisticas reais do explain para a busca textual indexada");
printjson(
  ecommerce.produtos.find({ $text: { $search: "camiseta" } })
    .explain("executionStats")
);
