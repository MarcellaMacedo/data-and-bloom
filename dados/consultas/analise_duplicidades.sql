
-- =====================================================
-- DATA & BLOOM | DADOS EM FOCO
-- Projeto: Identificação de registros duplicados
-- Banco de dados: SQLite
-- Base de dados: Cadastros escolares simulados
-- =====================================================


-- 01. VISÃO GERAL DA BASE
-- Total de registros e alunos distintos

SELECT
    COUNT(*) AS total_registros,
    COUNT(DISTINCT id_aluno) AS total_alunos
FROM cadastros_escolares;


-- 02. IDENTIFICAÇÃO DE POSSÍVEIS DUPLICIDADES
-- Alunos com mais de um registro

SELECT
    id_aluno,
    nome_aluno,
    COUNT(*) AS quantidade_registros
FROM cadastros_escolares
GROUP BY id_aluno, nome_aluno
HAVING COUNT(*) > 1;


-- 03. CLASSIFICAÇÃO DOS REGISTROS
-- Numeração dos registros por aluno

SELECT
    id_aluno,
    nome_aluno,
    id_registro,
    ROW_NUMBER() OVER (
        PARTITION BY id_aluno
        ORDER BY id_registro
    ) AS ordem
FROM cadastros_escolares;


-- 04. PRIORIZAÇÃO COM REGRAS DE NEGÓCIO
-- Ativos primeiro, depois matrícula mais recente
-- Em caso de empate, maior ID de registro

SELECT *
FROM (
    SELECT
        id_registro,
        id_aluno,
        nome_aluno,
        data_matricula,
        escola,
        status,
        ROW_NUMBER() OVER (
            PARTITION BY id_aluno
            ORDER BY
                CASE
                    WHEN status = 'Ativo' THEN 1
                    ELSE 2
                END,
                date(data_matricula) DESC,
                id_registro DESC
        ) AS ordem_prioridade
    FROM cadastros_escolares
) AS registros_classificados
ORDER BY id_aluno, ordem_prioridade;


-- 05. RESUMO DOS RESULTADOS
-- Quantidade de registros e possíveis duplicidades

SELECT
    COUNT(*) AS total_registros,
    COUNT(DISTINCT id_aluno) AS total_alunos,
    COUNT(*) - COUNT(DISTINCT id_aluno) AS registros_adicionais,
    ROUND(
        (
            (COUNT(*) - COUNT(DISTINCT id_aluno)) * 100.0
        ) / COUNT(*),
        2
    ) AS percentual_registros_adicionais
FROM cadastros_escolares;
