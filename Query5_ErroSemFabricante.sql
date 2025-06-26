/*
================================================================================
 5. Suporte de Chave Estrangeira
 Cenário: Tentativa de incluir uma nova vacina ("Vacina Fantasma") informando
 um ID de fabricante que não existe na tabela Fabricante.
================================================================================
*/
USE VacinaDB;
GO

PRINT '--- TENTATIVA DE INSERÇÃO INVÁLIDA ---';
PRINT 'Vamos tentar inserir uma vacina para o fabricante com ID 999 (que não existe).';
GO

-- Este comando vai FALHAR, como esperado.
INSERT INTO Vacina (Nome, Doses, ID_Fabricante)
VALUES ('Vacina Fantasma', 1, 999); -- O ID 999 não existe na tabela Fabricante.
GO

PRINT '--- CONCLUSÃO ---';
PRINT 'O comando acima falhou porque a chave estrangeira (FOREIGN KEY) na coluna ID_Fabricante protege a integridade do banco de dados, impedindo que uma vacina seja associada a um fabricante inexistente.';
GO
