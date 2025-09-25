-- Apaga o banco de dados se ele já existir, para garantir um começo limpo.
DROP DATABASE IF EXISTS ecommerce;

-- Criação do banco de dados para o cenário de E-Commerce
CREATE DATABASE ecommerce DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Seleciona o banco de dados a ser utilizado
USE ecommerce;

-- Tabela Cliente
CREATE TABLE Cliente (
    idClient INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    Telefone VARCHAR(20),
    Endereco VARCHAR(255)
);

-- Tabela Pessoa Física (Especialização de Cliente)
CREATE TABLE PessoaFisica (
    idCliente INT PRIMARY KEY,
    CPF VARCHAR(11) NOT NULL UNIQUE,
    CONSTRAINT fk_pessoafisica_cliente FOREIGN KEY (idCliente) REFERENCES Cliente(idClient) ON DELETE CASCADE
);

-- Tabela Pessoa Jurídica (Especialização de Cliente)
CREATE TABLE PessoaJuridica (
    idCliente INT PRIMARY KEY,
    CNPJ VARCHAR(14) NOT NULL UNIQUE,
    CONSTRAINT fk_pessoajuridica_cliente FOREIGN KEY (idCliente) REFERENCES Cliente(idClient) ON DELETE CASCADE
);

-- Tabela Produto
CREATE TABLE Produto (
    idProduto INT AUTO_INCREMENT PRIMARY KEY,
    NomeProduto VARCHAR(255) NOT NULL,
    Descricao TEXT,
    Preco DECIMAL(10, 2) NOT NULL,
    Categoria ENUM('Eletrônicos', 'Vestuário', 'Brinquedos', 'Alimentos', 'Móveis') NOT NULL
);

-- Tabela Fornecedor
CREATE TABLE Fornecedor (
    idFornecedor INT AUTO_INCREMENT PRIMARY KEY,
    RazaoSocial VARCHAR(255) NOT NULL,
    CNPJ VARCHAR(14) NOT NULL UNIQUE,
    Contato VARCHAR(255)
);

-- Tabela Estoque
CREATE TABLE Estoque (
    idEstoque INT AUTO_INCREMENT PRIMARY KEY,
    Local VARCHAR(255) NOT NULL,
    Responsavel VARCHAR(255)
);

-- Tabela Pedido
CREATE TABLE Pedido (
    idPedido INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT,
    StatusPedido ENUM('Em processamento', 'Enviado', 'Entregue', 'Cancelado') DEFAULT 'Em processamento',
    Descricao VARCHAR(255),
    Frete DECIMAL(10, 2),
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (idCliente) REFERENCES Cliente(idClient)
);

-- Tabela Pagamento
CREATE TABLE Pagamento (
    idPagamento INT AUTO_INCREMENT PRIMARY KEY,
    idPedido INT,
    FormaPagamento ENUM('Boleto', 'Cartão de Crédito', 'PIX') NOT NULL,
    ValorTotal DECIMAL(10, 2),
    Status ENUM('Pendente', 'Aprovado', 'Recusado') DEFAULT 'Pendente',
    CONSTRAINT fk_pagamento_pedido FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido)
);

-- Tabela Entrega
CREATE TABLE Entrega (
    idEntrega INT AUTO_INCREMENT PRIMARY KEY,
    idPedido INT,
    StatusEntrega ENUM('Preparando', 'Em trânsito', 'Entregue', 'Falha na entrega') NOT NULL,
    CodigoRastreio VARCHAR(50) UNIQUE,
    CONSTRAINT fk_entrega_pedido FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido)
);

-- Tabela de Ligação: Produto_Estoque
CREATE TABLE Produto_Estoque (
    idProduto INT,
    idEstoque INT,
    Quantidade INT NOT NULL DEFAULT 0,
    PRIMARY KEY (idProduto, idEstoque),
    CONSTRAINT fk_produto_estoque_produto FOREIGN KEY (idProduto) REFERENCES Produto(idProduto),
    CONSTRAINT fk_produto_estoque_estoque FOREIGN KEY (idEstoque) REFERENCES Estoque(idEstoque)
);

-- Tabela de Ligação: Produto_Fornecedor
CREATE TABLE Produto_Fornecedor (
    idFornecedor INT,
    idProduto INT,
    PRIMARY KEY (idFornecedor, idProduto),
    CONSTRAINT fk_produto_fornecedor_fornecedor FOREIGN KEY (idFornecedor) REFERENCES Fornecedor(idFornecedor),
    CONSTRAINT fk_produto_fornecedor_produto FOREIGN KEY (idProduto) REFERENCES Produto(idProduto)
);

-- Tabela de Ligação: Item_Pedido
CREATE TABLE Item_Pedido (
    idPedido INT,
    idProduto INT,
    Quantidade INT NOT NULL DEFAULT 1,
    PrecoUnitario DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (idPedido, idProduto),
    CONSTRAINT fk_item_pedido_pedido FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido),
    CONSTRAINT fk_item_pedido_produto FOREIGN KEY (idProduto) REFERENCES Produto(idProduto)
);

-- Tabela Vendedor (Terceiro)
CREATE TABLE Vendedor (
    idVendedor INT AUTO_INCREMENT PRIMARY KEY,
    RazaoSocial VARCHAR(255) NOT NULL,
    CNPJ VARCHAR(14) NOT NULL UNIQUE,
    Local VARCHAR(255)
);