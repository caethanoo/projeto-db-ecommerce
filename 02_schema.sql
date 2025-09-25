-- Seleciona o banco de dados a ser utilizado
USE ecommerce;

-- Inserindo Clientes (PF e PJ) - (IDs 1, 2, 3)
INSERT INTO Cliente (Nome, Email, Telefone, Endereco) VALUES 
('Maria Silva', 'maria.silva@email.com', '11987654321', 'Rua das Flores, 123, São Paulo, SP'),
('Tech Solutions Ltda', 'contato@techsolutions.com', '1155558888', 'Avenida Principal, 789, São Paulo, SP'),
('João Santos', 'joao.santos@email.com', '21998877665', 'Rua da Praia, 456, Rio de Janeiro, RJ');

INSERT INTO PessoaFisica (idCliente, CPF) VALUES 
(1, '12345678901'),
(3, '09876543210');

INSERT INTO PessoaJuridica (idCliente, CNPJ) VALUES 
(2, '12345678000199');

-- Inserindo Produtos - (IDs 1 a 5)
INSERT INTO Produto (NomeProduto, Descricao, Preco, Categoria) VALUES
('Smartphone Ultra X', 'Smartphone de última geração com 128GB', 2999.90, 'Eletrônicos'),
('Notebook Pro', 'Notebook com processador i7, 16GB RAM, SSD 512GB', 6500.00, 'Eletrônicos'),
('Camiseta Casual', 'Camiseta de algodão com estampa moderna', 89.90, 'Vestuário'),
('Calça Jeans Slim', 'Calça jeans de corte moderno e confortável', 159.90, 'Vestuário'),
('Carrinho de Controle Remoto', 'Carrinho de corrida super veloz', 250.00, 'Brinquedos');

-- Inserindo Fornecedores - (IDs 1, 2, 3)
INSERT INTO Fornecedor (RazaoSocial, CNPJ, Contato) VALUES 
('Eletrônicos Global', '11223344000155', 'contato@global.com'),
('Moda & Estilo', '55667788000144', 'vendas@modaestilo.com'),
('Brinquedos Felizes', '99887766000133', 'comercial@brinquedosfelizes.com.br');

-- Inserindo Estoques - (IDs 1, 2)
INSERT INTO Estoque (Local, Responsavel) VALUES 
('Depósito Central SP', 'Carlos Anes'),
('Filial RJ', 'Ana Pereira');

-- Ligando Produtos aos Fornecedores (N:M)
INSERT INTO Produto_Fornecedor (idFornecedor, idProduto) VALUES
(1, 1), (1, 2), (2, 3), (2, 4), (3, 5);

-- Colocando Produtos no Estoque (N:M)
INSERT INTO Produto_Estoque (idProduto, idEstoque, Quantidade) VALUES
(1, 1, 50), (2, 1, 20), (3, 2, 100), (4, 2, 80), (5, 1, 30);

-- Criando Pedidos - (IDs 1, 2, 3)
INSERT INTO Pedido (idCliente, StatusPedido, Descricao, Frete) VALUES
(1, 'Entregue', 'Compra de eletrônico', 15.00),
(2, 'Enviado', 'Pedido corporativo', 150.00),
(1, 'Em processamento', 'Compra de vestuário', 12.50);

-- Detalhando os Itens dos Pedidos (N:M)
INSERT INTO Item_Pedido (idPedido, idProduto, Quantidade, PrecoUnitario) VALUES
(1, 1, 1, 2999.90),
(2, 2, 5, 6500.00),
(3, 3, 2, 89.90),
(3, 4, 1, 159.90);

-- Inserindo Dados de Pagamento e Entrega
INSERT INTO Pagamento (idPedido, FormaPagamento, ValorTotal, Status) VALUES
(1, 'PIX', 3014.90, 'Aprovado'),
(2, 'Boleto', 32650.00, 'Aprovado'),
(3, 'Cartão de Crédito', 339.60, 'Pendente');

INSERT INTO Entrega (idPedido, StatusEntrega, CodigoRastreio) VALUES
(1, 'Entregue', 'BR123456789SP'),
(2, 'Em trânsito', 'BR987654321SP');

-- Inserindo Vendedores
INSERT INTO Vendedor (RazaoSocial, CNPJ, Local) VALUES
('Tech Eletro', '11223344000155', 'Rio de Janeiro'),
('Magazine Joana', '98765432000111', 'São Paulo');