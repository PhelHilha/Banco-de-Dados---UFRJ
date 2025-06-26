/*
================================================================================
 11. Constraints (CHECK) - Prepara��o da Tabela
Adicionar  uma constraint que impede que a quantidade seja maior que 100.
================================================================================
*/
USE VacinaDB;
GO

-- Adiciona a constraint que limita a quantidade a um m�ximo de 100
ALTER TABLE Lote
ADD CONSTRAINT CK_Lote_Quantidade CHECK (Quantidade <= 100);
GO

