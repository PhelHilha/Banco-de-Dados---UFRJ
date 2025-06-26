/*
================================================================================
 9. Unions
 Cen�rio: Criar uma consulta que unifique dois grupos de lotes:
    1. Lotes que est�o prestes a vencer (nos pr�ximos 30 dias).
    2. Lotes que venceram recentemente (nos �ltimos 30 dias).
================================================================================
*/
USE VacinaDB;
GO

-- Inserindo um lote que VAI VENCER em 15 dias.
INSERT INTO Lote(Codigo, Data_Fabricacao, Data_Validade, ID_Vacina)
VALUES ('VENCE_EM_BREVE', GETDATE(), DATEADD(day, 15, GETDATE()), 1);

-- Inserindo um lote que VENCEU h� 15 dias.
INSERT INTO Lote(Codigo, Data_Fabricacao, Data_Validade, ID_Vacina)
VALUES ('VENCEU_FAZ_POUCO_TEMPO', GETDATE(), DATEADD(day, -15, GETDATE()), 2);
GO


---
-- CONSULTA PRINCIPAL COM UNION
---

-- 1� Consulta: Lotes que vencem nos pr�ximos 30 dias
SELECT
    L.Codigo AS Codigo_Lote,
    V.Nome AS Nome_Vacina,
    L.Data_Validade,
    'Vence nos pr�ximos 30 dias' AS Status
FROM
    Lote AS L
INNER JOIN
    Vacina AS V ON L.ID_Vacina = V.ID_Vacina
WHERE
    L.Data_Validade BETWEEN GETDATE() AND DATEADD(day, 30, GETDATE())

UNION -- Une os resultados das duas consultas

-- 2� Consulta: Lotes que venceram nos �ltimos 30 dias
SELECT
    L.Codigo AS Codigo_Lote,
    V.Nome AS Nome_Vacina,
    L.Data_Validade,
    'Vencido nos �ltimos 30 dias' AS Status
FROM
    Lote AS L
INNER JOIN
    Vacina AS V ON L.ID_Vacina = V.ID_Vacina
WHERE
    L.Data_Validade BETWEEN DATEADD(day, -30, GETDATE()) AND GETDATE();
GO
