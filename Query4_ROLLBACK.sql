/*
================================================================================
 4. Transações - Exemplo de ROLLBACK (Cenário de Erro Catastrófico)
 Cenário: Um cara tenta apagar as aplicações de um lote específico,
 mas esquece a cláusula WHERE e apaga a tabela inteira por engano.
 O ROLLBACK salva o dia!
================================================================================
*/
USE VacinaDB;
GO

--- SITUAÇÃO ANTES DA TRANSAÇÃO, contamos o total de aplicações no sistema.
SELECT COUNT(*) AS 'Total de aplicações no banco de dados' 
FROM Aplicacao;
GO

-- Início da Transação
BEGIN TRANSACTION;

--- Dentro da Transação: O operador executa o DELETE sem WHERE por engano...';
DELETE FROM Aplicacao; -- ERRO! Apagando tudo!

-- Dentro da transação, vamos verificar o estrago.(TODOS os dados foram apagados vish)
SELECT COUNT(*) AS 'Total de aplicações (dentro da transação)' 
FROM Aplicacao;

-- EITA! ERRO GRAVE! Executando ROLLBACK para reverter a exclusão em massa >:)
ROLLBACK TRANSACTION;
GO
-- Fim da Transação
--- SITUAÇÃO DEPOIS DO ROLLBACK. A exclusão foi desfeita. Todos os dados voltaram ao estado original.
-- A consulta fora da transação confirma que todos os dados foram restaurados.
SELECT COUNT(*) AS 'Total de aplicações (após Rollback)' 
FROM Aplicacao;
GO
