-- Inserindo dados de exemplo na base de dados Oficina
USE oficina;

-- Inserindo Clientes
INSERT INTO Cliente (Nome, CPF, Endereco, Telefone) VALUES
('João Silva', '12345678901', 'Rua A, 123', '11987654321'),
('Maria Oliveira', '23456789012', 'Avenida B, 456', '21987654321');

-- Inserindo Veículos
INSERT INTO Veiculo (Placa, Modelo, Marca, Ano, idCliente) VALUES
('ABC-1234', 'Gol', 'Volkswagen', 2020, 1),
('DEF-5678', 'Onix', 'Chevrolet', 2021, 2);

-- Inserindo Equipes de Mecânicos
INSERT INTO Equipe_Mecanicos (NomeEquipe) VALUES
('Equipe Alpha - Motor e Câmbio'),
('Equipe Beta - Elétrica e Freios');

-- Inserindo Mecânicos
INSERT INTO Mecanico (Codigo, Nome, Endereco, Especialidade, idEquipe) VALUES
('MEC-001', 'Carlos Souza', 'Rua C, 789', 'Motor', 1),
('MEC-002', 'Pedro Rocha', 'Rua D, 101', 'Câmbio Automático', 1),
('MEC-003', 'Ana Lima', 'Avenida E, 202', 'Eletricista', 2);

-- Inserindo Serviços e Peças
INSERT INTO Servico (Descricao, ValorMaoDeObra) VALUES
('Troca de óleo e filtro', 100.00),
('Alinhamento e Balanceamento', 150.00),
('Revisão do sistema de freios', 200.00);

INSERT INTO Peca (NomePeca, ValorUnitario) VALUES
('Óleo de Motor 5W30 (Litro)', 50.00),
('Filtro de Óleo', 30.00),
('Pastilha de Freio (Par)', 120.00);

-- Inserindo Ordens de Serviço
INSERT INTO Ordem_Servico (Numero, DataEmissao, DataConclusao, ValorTotal, Status, idVeiculo, idEquipe) VALUES
('OS-2025-001', '2025-10-15', '2025-10-17', 310.00, 'Concluído', 1, 1),
('OS-2025-002', '2025-10-18', NULL, 0, 'Em Execução', 2, 2);

-- Associando Serviços e Peças às Ordens de Serviço
-- OS 1
INSERT INTO OS_Servicos (idOS, idServico) VALUES (1, 1);
INSERT INTO OS_Pecas (idOS, idPeca, Quantidade) VALUES (1, 1, 4), (1, 2, 1);

-- OS 2
INSERT INTO OS_Servicos (idOS, idServico) VALUES (2, 3);
INSERT INTO OS_Pecas (idOS, idPeca, Quantidade) VALUES (2, 3, 2);