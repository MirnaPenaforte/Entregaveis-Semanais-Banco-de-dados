// Semanas 07 e 08 — catálogo fictício de roupas
// Executar uma vez em mongosh conectado ao MongoDB local.

const ecommerce = db.getSiblingDB("ecommerce_db");

if (!ecommerce.getCollectionNames().includes("produtos")) {
  ecommerce.createCollection("produtos");
}

const produtos = [
  {
    sku: "CAM-001",
    nome: "Camiseta básica de algodão",
    descricao: "Camiseta confortável de algodão para uso diário.",
    categoria: "camisetas",
    preco: 79.9,
    tags: ["camiseta", "algodao", "basicos"],
    fabricante: { nome: "Têxtil Aurora", pais: "Brasil" },
    variacoes: [
      { tamanho: "P", cor: "Azul", estoque: 12 },
      { tamanho: "M", cor: "Azul", estoque: 8 },
      { tamanho: "M", cor: "Branca", estoque: 5 }
    ],
    ativo: true
  },
  {
    sku: "CAM-002",
    nome: "Camisa polo clássica",
    descricao: "Camisa polo de algodão com gola reforçada.",
    categoria: "camisas",
    preco: 129.9,
    tags: ["polo", "algodao", "promocao"],
    fabricante: { nome: "Malharia Horizonte", pais: "Brasil" },
    variacoes: [
      { tamanho: "M", cor: "Azul", estoque: 6 },
      { tamanho: "G", cor: "Preta", estoque: 9 }
    ],
    ativo: true
  },
  {
    sku: "CAL-001",
    nome: "Calça jeans reta",
    descricao: "Calça jeans resistente de corte reto.",
    categoria: "calcas",
    preco: 219.5,
    tags: ["jeans", "casual", "denim"],
    fabricante: { nome: "Denim do Sul", pais: "Brasil" },
    variacoes: [
      { tamanho: "40", cor: "Azul", estoque: 4 },
      { tamanho: "42", cor: "Preta", estoque: 7 }
    ],
    ativo: true
  },
  {
    sku: "MOL-001",
    nome: "Moletom urbano",
    descricao: "Moletom macio para dias frios, com capuz e bolso frontal.",
    categoria: "moletons",
    preco: 179.9,
    tags: ["moletom", "inverno", "promocao"],
    fabricante: { nome: "Têxtil Aurora", pais: "Brasil" },
    variacoes: [
      { tamanho: "M", cor: "Cinza", estoque: 10 },
      { tamanho: "G", cor: "Azul", estoque: 3 }
    ],
    ativo: true
  }
];

const resultado = ecommerce.produtos.insertMany(produtos);
print("Documentos inseridos:");
printjson(resultado);
print("Total de produtos na coleção:", ecommerce.produtos.countDocuments());
