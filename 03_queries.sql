-- Query 1: Lista de produtos e preços, ordenados por preço.
SELECT 
    NomeProduto, 
    Preco
FROM 
    Produto
ORDER BY 
    Preco DESC;
    
-- Query 2: Filtra pedidos por status.
SELECT 
    * FROM 
    Pedido
WHERE 
    StatusPedido = 'Enviado' OR StatusPedido = 'Entregue';
    
    
-- Query 3: Relação de produtos e seus fornecedores.
SELECT 
    p.NomeProduto,
    p.Preco,
    f.RazaoSocial AS NomeFornecedor,
    f.Contato
FROM 
    Produto AS p
INNER JOIN 
    Produto_Fornecedor AS pf ON p.idProduto = pf.idProduto
INNER JOIN 
    Fornecedor AS f ON pf.idFornecedor = f.idFornecedor
ORDER BY
    f.RazaoSocial;
    
-- Query 4 (continuação): Quantos pedidos foram feitos por cada cliente?
SELECT 
    c.Nome,
    COUNT(p.idPedido) AS TotalDePedidos
FROM 
    Cliente c
INNER JOIN 
    Pedido p ON c.idClient = p.idCliente
GROUP BY 
    c.idClient
ORDER BY
    TotalDePedidos DESC;
    
-- Query 5: Calcular o valor total de cada pedido.
SELECT 
    ip.idPedido,
    SUM(ip.Quantidade * ip.PrecoUnitario) AS ValorTotalDoPedido,
    p.Descricao
FROM 
    Item_Pedido ip
INNER JOIN
    Pedido p ON ip.idPedido = p.idPedido
GROUP BY 
    ip.idPedido;
    
-- Query 6: Clientes que fizeram mais de um pedido.
SELECT 
    c.Nome,
    COUNT(p.idPedido) AS TotalDePedidos
FROM 
    Cliente c
INNER JOIN 
    Pedido p ON c.idClient = p.idCliente
GROUP BY 
    c.idClient
HAVING 
    TotalDePedidos > 1;
    
-- Query 7: Vendedores que também são Fornecedores.
SELECT 
    f.RazaoSocial AS Nome,
    f.CNPJ
FROM 
    Fornecedor f
INNER JOIN 
    Vendedor v ON f.CNPJ = v.CNPJ;
