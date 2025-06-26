/*
================================================================================
 7. Stored Procedures
 Criar uma Stored Procedure que audita o sistema e retorna uma
 lista de todos os pacientes que receberam uma vacina vencida.
================================================================================
*/
USE VacinaDB;
GO

IF OBJECT_ID('sp_Pacientes_Com_Vacina_Vencida', 'P') IS NOT NULL
    DROP PROCEDURE sp_Pacientes_Com_Vacina_Vencida;
GO

--- Criando a Stored Procedure sp_Pacientes_Com_Vacina_Vencida


-- Comando para criar a Stored Procedure
CREATE PROCEDURE sp_Pacientes_Com_Vacina_Vencida
AS
BEGIN
    -- Configuração para não retornar a contagem de linhas afetadas
    SET NOCOUNT ON;

    -- A consulta principal que busca as inconsistências
    SELECT
        PF.Nome AS Nome_Paciente,
        V.Nome AS Nome_Vacina,
        L.Codigo AS Codigo_Lote,
        A.Data_Aplicacao,
        L.Data_Validade AS Data_Vencimento_Lote
    FROM
        Pessoa_Fisica AS PF
    INNER JOIN
        Aplicacao AS A ON PF.ID_Pessoa_Fisica = A.ID_Pessoa_Fisica
    INNER JOIN
        Lote AS L ON A.ID_Lote = L.ID_Lote
    INNER JOIN
        Vacina AS V ON L.ID_Vacina = V.ID_Vacina
    WHERE
        -- A lógica principal: a data da aplicação foi DEPOIS da data de validade
        A.Data_Aplicacao > L.Data_Validade
    ORDER BY
        A.Data_Aplicacao DESC;

END
GO

-- EXECUTANDO A PROCEDURE
EXEC sp_Pacientes_Com_Vacina_Vencida;
GO