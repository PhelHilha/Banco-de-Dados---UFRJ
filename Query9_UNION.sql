/*
================================================================================
 9. Unions
 Cenário: Criar uma consulta que unifique dois grupos de lotes:
    1. Lotes que estão prestes a vencer (nos próximos 30 dias).
    2. Lotes que venceram recentemente (nos últimos 30 dias).
================================================================================
*/
USE VacinaDB;
GO

-- Inserindo um lote que VAI VENCER em 15 dias.
INSERT INTO Lote(Codigo, Data_Fabricacao, Data_Validade, ID_Vacina)
VALUES ('VENCE_EM_BREVE', GETDATE(), DATEADD(day, 15, GETDATE()), 1);

-- Inserindo um lote que VENCEU há 15 dias.
INSERT INTO Lote(Codigo, Data_Fabricacao, Data_Validade, ID_Vacina)
VALUES ('VENCEU_FAZ_POUCO_TEMPO', GETDATE(), DATEADD(day, -15, GETDATE()), 2);
GO


---
-- CONSULTA PRINCIPAL COM UNION
---

-- 1ª Consulta: Lotes que vencem nos próximos 30 dias
SELECT
    L.Codigo AS Codigo_Lote,
    V.Nome AS Nome_Vacina,
    L.Data_Validade,
    'Vence nos próximos 30 dias' AS Status
FROM
    Lote AS L
INNER JOIN
    Vacina AS V ON L.ID_Vacina = V.ID_Vacina
WHERE
    L.Data_Validade BETWEEN GETDATE() AND DATEADD(day, 30, GETDATE())

UNION -- Une os resultados das duas consultas

-- 2ª Consulta: Lotes que venceram nos últimos 30 dias
SELECT
    L.Codigo AS Codigo_Lote,
    V.Nome AS Nome_Vacina,
    L.Data_Validade,
    'Vencido nos últimos 30 dias' AS Status
FROM
    Lote AS L
INNER JOIN
    Vacina AS V ON L.ID_Vacina = V.ID_Vacina
WHERE
    L.Data_Validade BETWEEN DATEADD(day, -30, GETDATE()) AND GETDATE();
GO
