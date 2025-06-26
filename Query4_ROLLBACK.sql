/*
================================================================================
 4. Transa��es - Exemplo de ROLLBACK (Cen�rio de Erro Catastr�fico)
 Cen�rio: Um cara tenta apagar as aplica��es de um lote espec�fico,
 mas esquece a cl�usula WHERE e apaga a tabela inteira por engano.
 O ROLLBACK salva o dia!
================================================================================
*/
USE VacinaDB;
GO

--- SITUA��O ANTES DA TRANSA��O, contamos o total de aplica��es no sistema.
SELECT COUNT(*) AS 'Total de aplica��es no banco de dados' 
FROM Aplicacao;
GO

-- In�cio da Transa��o
BEGIN TRANSACTION;

--- Dentro da Transa��o: O operador executa o DELETE sem WHERE por engano...';
DELETE FROM Aplicacao; -- ERRO! Apagando tudo!

-- Dentro da transa��o, vamos verificar o estrago.(TODOS os dados foram apagados vish)
SELECT COUNT(*) AS 'Total de aplica��es (dentro da transa��o)' 
FROM Aplicacao;

-- EITA! ERRO GRAVE! Executando ROLLBACK para reverter a exclus�o em massa >:)
ROLLBACK TRANSACTION;
GO
-- Fim da Transa��o
--- SITUA��O DEPOIS DO ROLLBACK. A exclus�o foi desfeita. Todos os dados voltaram ao estado original.
-- A consulta fora da transa��o confirma que todos os dados foram restaurados.
SELECT COUNT(*) AS 'Total de aplica��es (ap�s Rollback)' 
FROM Aplicacao;
GO
