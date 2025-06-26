/*
================================================================================
 11. Constraints (CHECK) - Demonstra��o
 Tentar inserir um lote com quantidade maior que 100
 para ver o erro da constraint em a��o.
================================================================================
*/
USE VacinaDB;
GO

---Tentativa de inser��o V�LIDA (Quantidade = 50)
-- A ideia � este INSERT funcionar normalmente.
INSERT INTO Lote (Codigo, Data_Fabricacao, Data_Validade, ID_Vacina, Quantidade)
VALUES ('LOTE_OK', GETDATE(), DATEADD(year, 2, GETDATE()), 1, 50);
GO


---Tentativa de inser��o INV�LIDA (Quantidade = 150)
-- Este INSERT ir� FALHAR, como esperado.
INSERT INTO Lote (Codigo, Data_Fabricacao, Data_Validade, ID_Vacina, Quantidade)
VALUES ('LOTE_GRANDE_DEMAIS', GETDATE(), DATEADD(year, 2, GETDATE()), 2, 150);
GO
