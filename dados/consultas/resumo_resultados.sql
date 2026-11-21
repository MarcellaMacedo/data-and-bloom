SELECT
    COUNT(*) AS total_registros,
    COUNT(DISTINCT id_aluno) AS alunos_distintos,

    SUM(
        CASE
            WHEN ordem_prioridade = 1 THEN 1
            ELSE 0
        END
    ) AS cadastros_prioritarios,

    SUM(
        CASE
            WHEN ordem_prioridade > 1 THEN 1
            ELSE 0
        END
    ) AS possiveis_duplicidades,

    ROUND(
        SUM(
            CASE
                WHEN ordem_prioridade > 1 THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS percentual_adicional

FROM (
    SELECT
        id_aluno,

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
) AS registros_classificados;