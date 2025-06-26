/*
================================================================================
 11. Constraints (CHECK) - Demonstração
 Tentar inserir um lote com quantidade maior que 100
 para ver o erro da constraint em ação.
================================================================================
*/
USE VacinaDB;
GO

---Tentativa de inserção VÁLIDA (Quantidade = 50)
-- A ideia é este INSERT funcionar normalmente.
INSERT INTO Lote (Codigo, Data_Fabricacao, Data_Validade, ID_Vacina, Quantidade)
VALUES ('LOTE_OK', GETDATE(), DATEADD(year, 2, GETDATE()), 1, 50);
GO


---Tentativa de inserção INVÁLIDA (Quantidade = 150)
-- Este INSERT irá FALHAR, como esperado.
INSERT INTO Lote (Codigo, Data_Fabricacao, Data_Validade, ID_Vacina, Quantidade)
VALUES ('LOTE_GRANDE_DEMAIS', GETDATE(), DATEADD(year, 2, GETDATE()), 2, 150);
GO
