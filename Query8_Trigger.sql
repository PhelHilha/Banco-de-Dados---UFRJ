/*
================================================================================
 8. Triggers
 Cen�rio: Criar um trigger que, ap�s a inser��o de um novo registro de
 vacina��o na tabela 'Aplicacao', atualiza automaticamente a coluna
 'Data_Aplicacao' para a data e hora atuais do sistema.
 Isso garante a auditoria e a precis�o dos dados, independentemente do que
 for informado no comando INSERT.
================================================================================
*/
USE VacinaDB;
GO

-- Apagar o Trigger se ele j� existir, para permitir a recria��o
IF OBJECT_ID('trg_Atualiza_Data_Vacinacao', 'TR') IS NOT NULL
    DROP TRIGGER trg_Atualiza_Data_Vacinacao;
GO

--- Criando o Trigger trg_Atualiza_Data_Vacinacao
-- Comando para criar o Trigger
CREATE TRIGGER trg_Atualiza_Data_Vacinacao
ON Aplicacao       -- O trigger pertence � tabela Aplicacao
AFTER INSERT       -- Ele dispara DEPOIS que um registro � inserido
AS
BEGIN
    -- Configura��o para n�o retornar a contagem de linhas afetadas
    SET NOCOUNT ON;

---TRIGGER: Atualizando a data da aplica��o para a data atual.';
-- Atualiza a tabela Aplicacao, ajustando a data apenas para os registros
-- que acabaram de ser inseridos (dispon�veis na tabela 'inserted').
    UPDATE A
    SET A.Data_Aplicacao = GETDATE() -- Define a data para a data/hora atual
    FROM
        Aplicacao AS A
    INNER JOIN
        inserted AS i ON A.ID_Aplicacao = i.ID_Aplicacao;
END
GO

-- TESTE
--- Inserindo um novo registro com uma data que antiga (1999-01-01)
-- Vamos tentar inserir uma aplica��o para 'Juliette' (ID 5) com a data antiga.
INSERT INTO Aplicacao (Data_Aplicacao, Dose, ID_Pessoa_Fisica, ID_Vacinador, ID_Unidade, ID_Lote)
VALUES ('1999-01-01', 'Dose Teste Trigger', 5, 2, 2, 4);
GO

-- Ao consultar o registro, veremos que o trigger ignorou '1999-01-01'
-- e salvou a data atual do sistema.
SELECT
    ID_Aplicacao,
    Data_Aplicacao,
    Dose,
    ID_Pessoa_Fisica
FROM
    Aplicacao
WHERE
    ID_Pessoa_Fisica = 5 AND Dose = 'Dose Teste Trigger';
GO
