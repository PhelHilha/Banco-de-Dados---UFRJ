/*
================================================================================
 6. Views
 Cen�rio: Criar uma VIEW para facilmente consultar todos os lotes de vacinas
 que j� passaram da data de validade. A VIEW tamb�m incluir� o nome da
 vacina e do fabricante para facilitar a identifica��o.
================================================================================
*/
USE VacinaDB;
GO

-- Apagar a VIEW se ela j� existir, para permitir a recria��o
IF OBJECT_ID('vw_Lotes_Vencidos', 'V') IS NOT NULL
    DROP VIEW vw_Lotes_Vencidos;
GO

PRINT '--- Criando a VIEW vw_Lotes_Vencidos ---';
GO

-- Comando para criar a VIEW
CREATE VIEW vw_Lotes_Vencidos AS
SELECT
    L.ID_Lote,
    L.Codigo AS Codigo_Lote,
    L.Data_Validade,
    V.Nome AS Nome_Vacina,
    PJ.Nome AS Nome_Fabricante
FROM
    Lote AS L
INNER JOIN
    Vacina AS V ON L.ID_Vacina = V.ID_Vacina
INNER JOIN
    Fabricante AS F ON V.ID_Fabricante = F.ID_Pessoa_Juridica
INNER JOIN
    Pessoa_Juridica AS PJ ON F.ID_Pessoa_Juridica = PJ.ID_Pessoa_Juridica
WHERE
    L.Data_Validade < GETDATE(); -- A l�gica principal: a data de validade � menor que a data atual
GO

PRINT 'VIEW criada com sucesso!';
GO

PRINT '--- Consultando a VIEW para ver os lotes vencidos ---';
-- Agora, para ver os lotes vencidos, basta fazer um simples SELECT na VIEW.
-- Com os dados de exemplo, e considerando a data atual, todos os 5 lotes aparecer�o.
SELECT * FROM vw_Lotes_Vencidos;
GO
