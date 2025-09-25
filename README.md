# Projeto de Banco de Dados para E-commerce com SQL

Este projeto consiste na modelagem e implementação de um banco de dados relacional completo para um cenário de e-commerce. O objetivo foi aplicar conceitos fundamentais e avançados de SQL, desde a criação do schema e das tabelas até a elaboração de queries complexas para responder a perguntas de negócio e extrair insights analíticos.

O desenvolvimento seguiu as diretrizes de um desafio de projeto, abordando a criação de um esquema lógico, persistência de dados para testes e a formulação de consultas SQL com diferentes níveis de complexidade.

---

## 🚀 Tecnologias Utilizadas
* **Linguagem:** SQL
* **SGBD:** MySQL
* **Cliente SQL:** MySQL Workbench
* **Versionamento:** Git & GitHub

---

## 📂 Estrutura do Projeto
O repositório está organizado da seguinte forma:
- **/sql**: Contém os scripts SQL do projeto.
  - `01_schema.sql`: Script para criação de todo o schema, tabelas, chaves e relacionamentos.
  - `02_data.sql`: Script para inserção de dados de teste (clientes, produtos, pedidos, etc.) para popular o banco.
  - `03_queries.sql`: Script com as consultas SQL desenvolvidas para responder às perguntas de negócio.
- `README.md`: Documentação completa do projeto.

---

## 📋 Modelo Relacional e Tabelas

O banco de dados foi modelado para suportar as principais operações de um e-commerce, incluindo o cadastro de clientes (com distinção entre Pessoa Física e Jurídica), catálogo de produtos, controle de estoque, processamento de pedidos, pagamentos e entregas.

As relações "Muitos para Muitos" (N:M) foram resolvidas através de tabelas de ligação, como `Item_Pedido`, `Produto_Fornecedor` e `Produto_Estoque`.

### Tabelas Principais:
* **`Cliente`**: Armazena dados comuns de todos os clientes.
* **`PessoaFisica`**: Tabela de especialização para clientes PF (contém o CPF).
* **`PessoaJuridica`**: Tabela de especialização para clientes PJ (contém o CNPJ).
* **`Produto`**: Catálogo de produtos disponíveis para venda.
* **`Pedido`**: Registra os pedidos feitos pelos clientes.
* **`Fornecedor`**: Armazena informações dos fornecedores de produtos.
* **`Estoque`**: Armazena informações sobre os locais de estoque.
* **`Pagamento`**: Controla as informações de pagamento associadas a cada pedido.
* **`Entrega`**: Controla o status e o código de rastreio da entrega de cada pedido.
* **`Item_Pedido`**: Tabela de ligação que detalha quais produtos e em que quantidade compõem cada pedido.
* **`Produto_Fornecedor`**: Tabela de ligação que indica qual fornecedor fornece qual produto.
* **`Produto_Estoque`**: Tabela de ligação que controla a quantidade de cada produto em cada estoque.

---

## ⚙️ Como Executar o Projeto

Para recriar e testar este banco de dados em sua máquina local, siga os passos abaixo:

1.  **Pré-requisitos:** Tenha o **MySQL Server** e o **MySQL Workbench** (ou outro cliente SQL de sua preferência) instalados.
2.  **Clone o Repositório:**
    ```bash
    git clone https://github.com/caethanoo/projeto-db-ecommerce
    ```
3.  **Crie o Schema:** Execute o script `sql/01_schema.sql` em seu cliente SQL. Isso criará o banco de dados `ecommerce` e todas as suas tabelas.
4.  **Popule o Banco:** Execute o script `sql/02_data.sql`. Isso inserirá todos os dados de teste nas tabelas.
5.  **Execute as Queries:** Abra o arquivo `sql/03_queries.sql` para ver e executar as consultas de análise.

---

## ❓ Exemplos de Queries (Perguntas de Negócio)

Abaixo estão algumas das consultas desenvolvidas para extrair informações estratégicas do banco de dados.

#### 1. Quantos pedidos foram feitos por cada cliente?
```sql
SELECT c.Nome, COUNT(p.idPedido) AS TotalDePedidos
FROM Cliente c
INNER JOIN Pedido p ON c.idClient = p.idCliente
GROUP BY c.idClient
ORDER BY TotalDePedidos DESC;
