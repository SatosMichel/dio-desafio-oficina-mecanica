-- Queries para a base de dados Oficina
USE oficina;

-- Pergunta 1: Quais clientes e veículos estão cadastrados no sistema?
-- Recuperação simples com SELECT e JOIN
SELECT
    c.Nome AS NomeCliente,
    c.CPF,
    v.Placa,
    v.Modelo,
    v.Marca
FROM Cliente c
JOIN Veiculo v ON c.idCliente = v.idCliente;


-- Pergunta 2: Quais ordens de serviço estão com status "Em Execução", ordenadas da mais recente para a mais antiga?
-- Filtro com WHERE e Ordenação com ORDER BY
SELECT
    Numero,
    DataEmissao,
    Status,
    idVeiculo
FROM Ordem_Servico
WHERE Status = 'Em Execução'
ORDER BY DataEmissao DESC;


-- Pergunta 3: Qual o valor total de peças para cada ordem de serviço?
-- Expressão para gerar atributo derivado (ValorTotalPecas) e Agrupamento com GROUP BY
SELECT
    os.Numero AS OrdemDeServico,
    SUM(p.ValorUnitario * op.Quantidade) AS ValorTotalPecas
FROM Ordem_Servico os
JOIN OS_Pecas op ON os.idOS = op.idOS
JOIN Peca p ON op.idPeca = p.idPeca
GROUP BY os.Numero;


-- Pergunta 4: Quais equipes de mecânicos geraram um valor total em mão de obra superior a R$ 150,00?
-- Junções, agrupamento e filtro de grupo com HAVING
SELECT
    em.NomeEquipe,
    SUM(s.ValorMaoDeObra) AS TotalMaoDeObra
FROM Equipe_Mecanicos em
JOIN Ordem_Servico os ON em.idEquipe = os.idEquipe
JOIN OS_Servicos oss ON os.idOS = oss.idOS
JOIN Servico s ON oss.idServico = s.idServico
GROUP BY em.NomeEquipe
HAVING TotalMaoDeObra > 150.00;


-- Pergunta 5: Listar todos os detalhes de uma Ordem de Serviço específica, incluindo cliente, veículo, equipe, serviços realizados e peças utilizadas.
-- Junções complexas entre múltiplas tabelas
SELECT
    os.Numero AS OrdemDeServico,
    os.Status,
    os.DataEmissao,
    c.Nome AS Cliente,
    v.Placa AS Veiculo,
    em.NomeEquipe AS EquipeResponsavel,
    s.Descricao AS ServicoRealizado,
    p.NomePeca AS PecaUtilizada,
    op.Quantidade
FROM Ordem_Servico os
JOIN Veiculo v ON os.idVeiculo = v.idVeiculo
JOIN Cliente c ON v.idCliente = c.idCliente
JOIN Equipe_Mecanicos em ON os.idEquipe = em.idEquipe
LEFT JOIN OS_Servicos oss ON os.idOS = oss.idOS
LEFT JOIN Servico s ON oss.idServico = s.idServico
LEFT JOIN OS_Pecas op ON os.idOS = op.idOS
LEFT JOIN Peca p ON op.idPeca = p.idPeca
WHERE os.Numero = 'OS-2025-001';