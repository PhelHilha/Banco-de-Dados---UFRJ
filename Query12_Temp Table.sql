/*
================================================================================
 12. Tabela Temporária Global
 Criar uma tabela temporária global (##) que contém uma cópia
 dos dados dos fabricantes, incluindo o nome e o país de origem.
================================================================================
*/
USE VacinaDB;
GO

--- Criando a Tabela Temporária Global ##FabricantesGlobais
-- Apagar a tabela temporária global se ela já existir, para garantir que o script possa ser executado novamente sem erros.
IF OBJECT_ID('tempdb..##FabricantesGlobais') IS NOT NULL
    DROP TABLE ##FabricantesGlobais;
GO

-- Criar e popular a tabela temporária global em um único passo
SELECT
    F.ID_Pessoa_Juridica,
    PJ.Nome AS Nome_Fabricante,
    P.Nome AS Pais_Origem
INTO
    ##FabricantesGlobais -- O prefixo ## a torna uma tabela global
FROM
    Fabricante AS F
INNER JOIN
    Pessoa_Juridica AS PJ ON F.ID_Pessoa_Juridica = PJ.ID_Pessoa_Juridica
INNER JOIN
    Pais AS P ON F.ID_Pais_Origem = P.ID_Pais;
GO
-- Qualquer sessão conectada ao SQL Server agora pode consultar esta tabela.
SELECT * FROM ##FabricantesGlobais;
GO

