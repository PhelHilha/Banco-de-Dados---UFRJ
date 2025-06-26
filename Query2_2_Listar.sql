/*
================================================================================
 PARTE 1: LISTAGEM DE TABELAS E CONTAGEM DE REGISTROS (CARDINALIDADE DO CONJUNTO)
 Este bloco de código conta e exibe o número total de registros em cada tabela,
 mostrando apenas o nome da tabela, sem o esquema [dbo].
================================================================================
*/
USE VacinaDB;
GO

PRINT '=================================================================';
PRINT ' PARTE 1: TOTAL DE REGISTROS POR TABELA';
PRINT '=================================================================';
GO

-- Tabela temporária para armazenar os resultados da contagem
IF OBJECT_ID('tempdb..#Cardinalidade') IS NOT NULL DROP TABLE #Cardinalidade;
CREATE TABLE #Cardinalidade (
    NomeTabela NVARCHAR(128),
    TotalRegistros INT
);

-- Script dinâmico para contar registros em todas as tabelas
-- A função PARSENAME(''?'', 1) extrai apenas o nome do objeto, removendo o [dbo].
EXEC sp_MSforeachtable '
    INSERT INTO #Cardinalidade (NomeTabela, TotalRegistros)
    SELECT PARSENAME(''?'', 1), COUNT(*) FROM ?;
';

-- Exibir resultados da contagem
SELECT 
    NomeTabela, 
    TotalRegistros
FROM 
    #Cardinalidade
ORDER BY 
    NomeTabela;
GO


/*
================================================================================
 PARTE 2: LISTAGEM DOS RELACIONAMENTOS (CARDINALIDADE DOS RELACIONAMENTOS)
 Este bloco de código já exibe os nomes das tabelas sem o esquema.
================================================================================
*/

PRINT '=================================================================';
PRINT ' PARTE 2: RELACIONAMENTOS ENTRE AS TABELAS (CARDINALIDADE N:1)';
PRINT '=================================================================';
GO

SELECT
    fk.name AS 'Nome_da_Constraint_FK',
    tp.name AS 'Tabela_Origem (Lado N)',
    tr.name AS 'Tabela_Destino (Lado 1)',
    'N:1' AS 'Cardinalidade_Implementada'
FROM 
    sys.foreign_keys AS fk
INNER JOIN 
    sys.tables AS tp ON fk.parent_object_id = tp.object_id
INNER JOIN 
    sys.tables AS tr ON fk.referenced_object_id = tr.object_id
ORDER BY 
    [Tabela_Destino (Lado 1)], [Tabela_Origem (Lado N)];
GO