/*
================================================================================
 13. Cursors
 Cenário: Declarar um cursor para percorrer todos os registros de aplicação e
 gerar uma saída de texto formatada, mostrando a data da aplicação, o nome
 do paciente, o código do lote e o nome do fabricante da vacina.
================================================================================
*/
USE VacinaDB;
GO

-- Todo o script do cursor agora está em um único bloco, sem 'GO' para separar.
BEGIN
    -- 1. Declarar as variáveis que vão receber os dados de cada linha do cursor
    DECLARE @DataAplicacao DATE;
    DECLARE @NomePaciente VARCHAR(100);
    DECLARE @CodigoLote VARCHAR(50);
    DECLARE @NomeFabricante VARCHAR(100);

    PRINT '--- Iniciando a execução do Cursor ---';

    -- 2. Declarar o CURSOR, associando-o a uma consulta SELECT
    DECLARE cursor_aplicacoes CURSOR FOR
    SELECT
        A.Data_Aplicacao,
        PF.Nome,
        L.Codigo,
        PJ.Nome AS FabricanteNome
    FROM
        Aplicacao AS A
    INNER JOIN
        Pessoa_Fisica AS PF ON A.ID_Pessoa_Fisica = PF.ID_Pessoa_Fisica
    INNER JOIN
        Lote AS L ON A.ID_Lote = L.ID_Lote
    INNER JOIN
        Vacina AS V ON L.ID_Vacina = V.ID_Vacina
    INNER JOIN
        Fabricante AS F ON V.ID_Fabricante = F.ID_Pessoa_Juridica
    INNER JOIN
        Pessoa_Juridica AS PJ ON F.ID_Pessoa_Juridica = PJ.ID_Pessoa_Juridica
    ORDER BY
        A.Data_Aplicacao;

    -- 3. Abrir o CURSOR para poder utilizá-lo
    OPEN cursor_aplicacoes;

    -- 4. Obter a primeira linha do cursor e armazenar os dados nas variáveis
    FETCH NEXT FROM cursor_aplicacoes INTO @DataAplicacao, @NomePaciente, @CodigoLote, @NomeFabricante;

    -- 5. Loop para percorrer todas as linhas do cursor
    -- A variável global @@FETCH_STATUS retorna 0 enquanto houver linhas a serem lidas.
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Gera a saída formatada para a linha atual
        PRINT 'Em ' + CONVERT(VARCHAR, @DataAplicacao, 103) + ', o paciente ' + @NomePaciente + ' tomou a vacina do lote ' + @CodigoLote + ' (Fabricante: ' + @NomeFabricante + ').';

        -- Pega a próxima linha para a próxima iteração do loop
        FETCH NEXT FROM cursor_aplicacoes INTO @DataAplicacao, @NomePaciente, @CodigoLote, @NomeFabricante;
    END;

    -- 6. Fechar o CURSOR após o uso
    CLOSE cursor_aplicacoes;

    -- 7. Liberar os recursos alocados pelo CURSOR
    DEALLOCATE cursor_aplicacoes;

    PRINT '--- Fim da execução do Cursor ---';
END;
GO
