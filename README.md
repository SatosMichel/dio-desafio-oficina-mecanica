# Desafio de Projeto DIO: Da Modelagem ao Banco de Dados de Oficina

Repositório criado para documentar a resolução dos desafios de projeto de banco de dados da [Digital Innovation One (DIO)](https://www.dio.me/), cobrindo desde a modelagem conceitual até a implementação e consulta de um banco de dados para uma oficina mecânica.

---

## Evolução do Desafio

Este projeto foi construído em duas etapas:

1.  **Desafio 1 (Concluído):** Foco na criação do esquema conceitual (Modelo Entidade-Relacionamento) a partir de uma narrativa.
2.  **Desafio 2 (Adicionado Posteriormente):** Foco na implementação do esquema lógico, criação do banco de dados com scripts SQL, povoamento com dados e elaboração de consultas complexas.

---

## Desafio 1: Modelagem Conceitual

Nesta primeira fase, o objetivo foi interpretar a narrativa de negócio e projetar um esquema conceitual que representasse as entidades, seus atributos e os relacionamentos entre elas.

#### **Diagrama Conceitual Resultante:**

![Esquema Conceitual da Oficina](mermaid-diagram-2025-10-18-230211.png)

---

## Desafio 2: Esquema Lógico e Scripts SQL

Após a conclusão da modelagem conceitual, o projeto foi expandido para a fase de implementação. Esta seção foi **adicionada posteriormente** e contém todos os artefatos necessários para criar e consultar o banco de dados funcional.

### Estrutura dos Arquivos SQL

O repositório foi atualizado com os seguintes scripts:

1.  **[schema.sql](schema.sql):** Script DDL (Data Definition Language) responsável por criar o banco de dados `oficina` e todas as suas tabelas, definindo chaves primárias, estrangeiras e constraints.

2.  **[inserts.sql](inserts.sql):** Script DML (Data Manipulation Language) que popula todas as tabelas com dados de exemplo para permitir a execução e teste das consultas.

3.  **[queries.sql](queries.sql):** Script DQL (Data Query Language) que contém uma série de perguntas de negócio e as consultas SQL desenvolvidas para respondê-las, utilizando cláusulas como `JOIN`, `WHERE`, `GROUP BY`, `HAVING` e `ORDER BY`.

### Perguntas de Negócio e Queries Desenvolvidas

Abaixo estão as perguntas e as consultas SQL do arquivo `queries.sql`.

#### 1. Quais clientes e veículos estão cadastrados no sistema?
```sql
SELECT c.Nome AS NomeCliente, c.CPF, v.Placa, v.Modelo, v.Marca
FROM Cliente c JOIN Veiculo v ON c.idCliente = v.idCliente;
```

#### 2. Quais ordens de serviço estão "Em Execução"?
```sql
SELECT Numero, DataEmissao, Status, idVeiculo
FROM Ordem_Servico WHERE Status = 'Em Execução' ORDER BY DataEmissao DESC;
```

#### 3. Qual o valor total de peças para cada ordem de serviço?
```sql
SELECT os.Numero AS OrdemDeServico, SUM(p.ValorUnitario * op.Quantidade) AS ValorTotalPecas
FROM Ordem_Servico os JOIN OS_Pecas op ON os.idOS = op.idOS JOIN Peca p ON op.idPeca = p.idPeca
GROUP BY os.Numero;
```

#### 4. Quais equipes geraram um valor em mão de obra superior a R$ 150,00?
```sql
SELECT em.NomeEquipe, SUM(s.ValorMaoDeObra) AS TotalMaoDeObra
FROM Equipe_Mecanicos em JOIN Ordem_Servico os ON em.idEquipe = os.idEquipe JOIN OS_Servicos oss ON os.idOS = oss.idOS JOIN Servico s ON oss.idServico = s.idServico
GROUP BY em.NomeEquipe HAVING TotalMaoDeObra > 150.00;
```

#### 5. Listar todos os detalhes de uma Ordem de Serviço específica.
```sql
SELECT os.Numero AS OrdemDeServico, os.Status, c.Nome AS Cliente, v.Placa AS Veiculo, em.NomeEquipe AS EquipeResponsavel, s.Descricao AS ServicoRealizado, p.NomePeca AS PecaUtilizada
FROM Ordem_Servico os
JOIN Veiculo v ON os.idVeiculo = v.idVeiculo
JOIN Cliente c ON v.idCliente = c.idCliente
JOIN Equipe_Mecanicos em ON os.idEquipe = em.idEquipe
LEFT JOIN OS_Servicos oss ON os.idOS = oss.idOS
LEFT JOIN Servico s ON oss.idServico = s.idServico
LEFT JOIN OS_Pecas op ON os.idOS = op.idOS
LEFT JOIN Peca p ON op.idPeca = p.idPeca
WHERE os.Numero = 'OS-2025-001';
```
