/*
================================================================================
 3. Suporte a Sub-selects
 Lista os nomes dos pacientes que tomaram vacinas de TODOS os fabricantes existentes.
================================================================================
*/
USE VacinaDB;
GO

SELECT 
    PF.Nome
FROM 
    Pessoa_Fisica AS PF
INNER JOIN 
    Aplicacao AS A ON PF.ID_Pessoa_Fisica = A.ID_Pessoa_Fisica
INNER JOIN 
    Lote AS L ON A.ID_Lote = L.ID_Lote
INNER JOIN 
    Vacina AS V ON L.ID_Vacina = V.ID_Vacina -- Join para chegar na tabela Vacina
GROUP BY 
    PF.ID_Pessoa_Fisica, PF.Nome
HAVING 
    COUNT(DISTINCT V.ID_Fabricante) = (
        SELECT COUNT(*) FROM Fabricante
    );
