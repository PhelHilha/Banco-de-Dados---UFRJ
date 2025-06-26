/*
================================================================================
 4. Transa��es - Exemplo de COMMIT
 Cen�rio: O paciente 'Pedro Lima' (ID 3) se casou novamente.
 Vamos atualizar seu estado civil de 'Divorciado' para 'Casado'.
================================================================================
*/
USE VacinaDB;
GO
-- Estado Civil da Pessoa de ID 3 antes do COMMIT
SELECT 
    PF.Nome,
    EC.Descricao AS EstadoCivil
FROM 
    Pessoa_Fisica AS PF
INNER JOIN 
    Estado_Civil AS EC ON PF.ID_Estado_Civil = EC.ID_Estado_Civil
WHERE 
    PF.ID_Pessoa_Fisica = 3;
GO

-- In�cio da Transa��o
BEGIN TRANSACTION;

PRINT '--> Dentro da Transa��o: Atualizando o estado civil...';

UPDATE Pessoa_Fisica
SET ID_Estado_Civil = 2 -- O ID para 'Casado' � 2
WHERE ID_Pessoa_Fisica = 3;

-- Dentro da transa��o, a mudan�a j� � vis�vel para esta sess�o
SELECT 
    PF.Nome,
    EC.Descricao AS EstadoCivil
FROM 
    Pessoa_Fisica AS PF
INNER JOIN 
    Estado_Civil AS EC ON PF.ID_Estado_Civil = EC.ID_Estado_Civil
WHERE 
    PF.ID_Pessoa_Fisica = 3;

-- Confirmando a transa��o , uso do COMMIT
COMMIT TRANSACTION;
GO

-- A consulta fora da transa��o confirma que o COMMIT tornou as atualiza��es permanentes
SELECT 
    PF.Nome,
    EC.Descricao AS EstadoCivil
FROM 
    Pessoa_Fisica AS PF
INNER JOIN 
    Estado_Civil AS EC ON PF.ID_Estado_Civil = EC.ID_Estado_Civil
WHERE 
    PF.ID_Pessoa_Fisica = 3;
GO
