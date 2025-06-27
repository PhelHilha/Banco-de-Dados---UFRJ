-- Script para carregar dados (Versão Final)
-- Lembre-se de executar o script de CRIAÇÃO das tabelas antes deste.

USE VacinaDB;
GO

-- TABELAS BASE (sem dependências)
INSERT INTO Sexo (Descricao) VALUES
('Masculino'), ('Feminino'), ('Outro'), ('Não Informado'), ('Prefere não dizer');

INSERT INTO Estado_Civil (Descricao) VALUES
('Solteiro'), ('Casado'), ('Divorciado'), ('Viúvo'), ('União Estável');

INSERT INTO Pais (Nome) VALUES
('Brasil'), ('Argentina'), ('Chile'), ('Paraguai'), ('Uruguai');

INSERT INTO Nacionalidade (Nome, ID_Pais) VALUES
('Brasileira', 1), ('Argentina', 2), ('Chilena', 3), ('Paraguaia', 4), ('Uruguaia', 5);

INSERT INTO Estado (Nome, Sigla, ID_Pais) VALUES
('Rio de Janeiro', 'RJ', 1), ('São Paulo', 'SP', 1), ('Buenos Aires', 'BA', 2), ('Montevidéu', 'MT', 5), ('Assunção', 'AS', 4);

INSERT INTO Cidade (Nome, ID_Estado) VALUES
('Rio de Janeiro', 1), ('Niterói', 1), ('São Paulo', 2), ('La Plata', 3), ('Montevidéu', 4);

INSERT INTO Bairro (Nome, ID_Cidade) VALUES
('Centro', 1), ('Icaraí', 2), ('Paulista', 3), ('Belgrano', 4), ('Carrasco', 5);

INSERT INTO Logradouro (Nome, CEP, ID_Bairro) VALUES
('Rua A', '20000-000', 1), ('Rua B', '20000-001', 2), ('Av. Paulista', '01311-000', 3), ('Calle 9', '1900', 4), ('Rua X', '11000', 5);

INSERT INTO Complemento (Descricao) VALUES
('Apto 101'), ('Casa'), ('Fundos'), ('Cobertura'), ('Loja');

INSERT INTO Endereco (Numero, ID_Logradouro, ID_Complemento) VALUES
('100', 1, 1), ('200', 2, 2), ('300', 3, 3), ('400', 4, 4), ('500', 5, 5);

-- PESSOAS
INSERT INTO Pessoa_Fisica (Nome, Data_Nascimento, RG, ID_Sexo, ID_Estado_Civil, ID_Nacionalidade) VALUES
('Enzo Sampaio', '1990-01-01', '1234567', 1, 1, 1),
('Jeson ChenWen', '1985-05-10', '2345678', 3, 2, 2),
('Nilce Moretto', '1978-07-22', '3456789', 2, 3, 3),
('Davi Brito', '2000-03-15', '4567890', 4, 4, 4),
('Juliette', '1995-08-09', '5678901', 5, 5, 5);

INSERT INTO Pessoa_Juridica (Nome, Contato) VALUES
-- Unidades de Saúde (IDs 1-5)
('Clínica Saúde RJ', '21 99999-0001'),
('Posto Central SP', '11 99999-0002'),
('Hospital Belgrano', '54 99999-0003'),
('Unidade Saúde Montevidéu', '598 99999-0004'),
('Centro Paraguaio', '595 99999-0005'),
-- Fabricantes (IDs 6-10)
('Seringas & Samba Ltda', 'falecom@samba.com.br'),
('Tango Tecno-Vaxx', 'che@tangovaxx.com.ar'),
('Laboratórios Pimenta Picante', 'caliente@pimenta.cl'),
('Chip-Guaraná Biofarmaceutica', 'terere@chipguarana.com.py'),
('Garrón Celeste Farma', 'mate@garraoceleste.com.uy');

INSERT INTO Genero (Descricao) VALUES
('Homem Cis'), ('Mulher Cis'), ('Mulher Trans'), ('Homem Trans'), ('Não Binário');

INSERT INTO Pessoa_Genero (ID_Pessoa_Fisica, ID_Genero) VALUES
(1,1), (2,3), (3,2), (4,4), (5,5);

-- TELEFONES
INSERT INTO Telefone (Numero) VALUES
('21988880001'), ('21988880002'), ('11999990001'), ('5411110001'), ('5982220001');

INSERT INTO Tipo_Telefone (Descricao) VALUES
('Residencial'), ('Comercial'), ('Celular'), ('Emergência'), ('WhatsApp');

INSERT INTO Contato_Telefone (ID_Pessoa_Fisica, ID_Tipo_Telefone, ID_Telefone) VALUES
(1, 1, 1), (2, 3, 2), (3, 2, 3), (4, 4, 4), (5, 5, 5);

-- RESIDÊNCIAS
INSERT INTO Residencia (ID_Pessoa_Fisica, ID_Endereco, ID_Pessoa_Juridica, Principal) VALUES
(1, 1, 1, 1), (2, 2, 2, 1), (3, 3, 3, 1), (4, 4, 4, 1), (5, 5, 5, 1);

-- VACINAÇÃO
INSERT INTO Vacinador (ID_Pessoa_Fisica) VALUES
(1), (2), (3), (4), (5);

INSERT INTO Fabricante (ID_Pessoa_Juridica, ID_Pais_Origem) VALUES
(6, 1), (7, 2), (8, 3), (9, 4), (10, 5);

INSERT INTO Doenca (Nome) VALUES
('COVID-19'), ('Gripe'), ('Febre Amarela'), ('Sarampo'), ('HPV');

INSERT INTO Vacina (Nome, Doses, ID_Fabricante) VALUES
('SambaVax', 2, 6),
('TangoFlu', 3, 7),
('PicaPicaBlock', 1, 8),
('GuaraniGuard', 2, 9),
('CelesteShield', 2, 10);

INSERT INTO Protege_Contra (ID_Vacina, ID_Doenca) VALUES
(1,1), (2,2), (3,3), (4,4), (5,5);

INSERT INTO Lote (Codigo, Data_Fabricacao, Data_Validade, ID_Vacina, Quantidade) VALUES
('L001', '2021-01-01', '2023-01-01', 1, 100), -- Vencido
('L002', '2022-02-01', '2024-02-01', 2, 64),  -- Vencido
('L003', '2023-03-01', '2025-03-01', 3, 98),  -- Vencido
('L004', '2024-04-01', '2026-04-01', 4, 42),
('L005', '2025-05-01', '2027-05-01', 5, 70);

INSERT INTO Unidade_Saude (ID_Pessoa_Juridica, ID_Endereco) VALUES
(1,1), (2,2), (3,3), (4,4), (5,5);

INSERT INTO Aplicacao (Data_Aplicacao, Dose, ID_Pessoa_Fisica, ID_Vacinador, ID_Unidade, ID_Lote) VALUES
-- Paciente 1: Enzo Sampaio (todas as 5 vacinas)
('2022-01-01', '1ª Dose', 1, 1, 1, 1),
('2023-02-01', '1ª Dose', 1, 2, 2, 2),
('2023-03-01', 'Única',   1, 3, 3, 3),
('2024-04-01', '1ª Dose', 1, 4, 4, 4),
('2025-05-01', '1ª Dose', 1, 5, 5, 5),

-- Paciente 2: Jeson ChenWen (todas as 5 vacinas)
('2022-01-02', '1ª Dose', 2, 1, 1, 1),
('2023-02-02', '1ª Dose', 2, 2, 2, 2),
('2023-03-02', 'Única',   2, 3, 3, 3),
('2024-04-02', '1ª Dose', 2, 4, 4, 4),
('2025-05-02', '1ª Dose', 2, 5, 5, 5),

-- Paciente 3: Nilce Moretto (1 vacina)
('2025-03-03', 'Única',   3, 3, 3, 3),

-- Paciente 4: Davi Brito (3 vacinas)
('2022-01-04', '1ª Dose', 4, 1, 1, 1),
('2023-02-04', '1ª Dose', 4, 2, 2, 2),
('2025-05-04', '1ª Dose', 4, 5, 5, 5),

-- Paciente 5: Juliette (1 vacina vencida)
-- Este caso será pego pela Stored Procedure da Atividade 7
('2024-06-20', 'Dose Vencida', 5, 1, 1, 1); -- Lote 1 venceu em 2023

INSERT INTO Vacinador_Unidade (ID_Vacinador, ID_Unidade) VALUES
(1,1), (2,2), (3,3), (4,4), (5,5);
