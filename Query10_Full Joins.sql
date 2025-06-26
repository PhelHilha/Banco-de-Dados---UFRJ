/*
================================================================================
 10. Full Joins (Corrigido)
 Cenário: Unir Fabricante e Vacina, mostrando NULL nos dois lados.
================================================================================
*/
USE VacinaDB;
GO

--- Inserindo um Fabricante que não possui vacinas para teste
INSERT INTO Pessoa_Juridica (Nome, Contato) VALUES ('Los Pollos Hermanos', 'contato@badbreaking.com');
INSERT INTO Fabricante (ID_Pessoa_Juridica, ID_Pais_Origem) VALUES (SCOPE_IDENTITY(), 1);
GO

--- Inserindo uma Vacina sem fabricante para teste
INSERT INTO Vacina (Nome, Doses, ID_Fabricante)
VALUES ('Sobrou nada pra Vacininha', 1, NULL);
GO

SELECT
    PJ.Nome AS Nome_Fabricante,
    V.Nome AS Nome_Vacina
FROM
    Fabricante AS F
INNER JOIN
    Pessoa_Juridica AS PJ ON F.ID_Pessoa_Juridica = PJ.ID_Pessoa_Juridica
FULL JOIN
    Vacina AS V ON F.ID_Pessoa_Juridica = V.ID_Fabricante
ORDER BY
    PJ.Nome;
GO
