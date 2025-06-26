/*
================================================================================
 4. Transações - Exemplo de COMMIT
 Cenário: O paciente 'Pedro Lima' (ID 3) se casou novamente.
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

-- Início da Transação
BEGIN TRANSACTION;

PRINT '--> Dentro da Transação: Atualizando o estado civil...';

UPDATE Pessoa_Fisica
SET ID_Estado_Civil = 2 -- O ID para 'Casado' é 2
WHERE ID_Pessoa_Fisica = 3;

-- Dentro da transação, a mudança já é visível para esta sessão
SELECT 
    PF.Nome,
    EC.Descricao AS EstadoCivil
FROM 
    Pessoa_Fisica AS PF
INNER JOIN 
    Estado_Civil AS EC ON PF.ID_Estado_Civil = EC.ID_Estado_Civil
WHERE 
    PF.ID_Pessoa_Fisica = 3;

-- Confirmando a transação , uso do COMMIT
COMMIT TRANSACTION;
GO

-- A consulta fora da transação confirma que o COMMIT tornou as atualizações permanentes
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
