create database avaliacao_1
use avaliacao_1

select*from  garantia_safra


-- EXERCÍCIO 1


-- 1.1 
WITH base_2020 AS (
    SELECT *
    FROM garantia_safra
    WHERE ano_referencia >= 2020
)
SELECT * FROM base_2020;


-- 1.2 
WITH
base_2020 AS (
    SELECT *
    FROM garantia_safra
    WHERE ano_referencia >= 2020
),
totais_uf_ano AS (
    SELECT
        sigla_uf,
        ano_referencia,
        SUM(valor_parcela) AS valor_total,
        COUNT(*)           AS qtd_parcelas
    FROM base_2020
    GROUP BY sigla_uf, ano_referencia
)
SELECT * FROM totais_uf_ano;


-- 1.3 
WITH
base_2020 AS (
    SELECT *
    FROM garantia_safra
    WHERE ano_referencia >= 2020
),
contagens_uf_ano AS (
    SELECT
        sigla_uf,
        ano_referencia,
        COUNT(DISTINCT nis_favorecido) AS beneficiarios_unicos,
        COUNT(DISTINCT id_municipio)   AS municipios_atendidos
    FROM base_2020
    GROUP BY sigla_uf, ano_referencia
)
SELECT * FROM contagens_uf_ano;


--  1.4 
WITH
base_2020 AS (
    SELECT *
    FROM garantia_safra
    WHERE ano_referencia >= 2020
),
estatisticas_uf_ano AS (
    SELECT
        sigla_uf,
        ano_referencia,
        AVG(valor_parcela) AS ticket_medio,
        MAX(valor_parcela) AS maior_valor
    FROM base_2020
    GROUP BY sigla_uf, ano_referencia
)
SELECT * FROM estatisticas_uf_ano;


-- 1.5 
WITH
base_2020 AS (
    SELECT *
    FROM garantia_safra
    WHERE ano_referencia >= 2020
),
faixas_uf_ano AS (
    SELECT
        sigla_uf,
        ano_referencia,
        SUM(CASE WHEN valor_parcela >= 800 THEN 1 ELSE 0 END)                         AS qtd_alta,
        SUM(CASE WHEN valor_parcela >= 500 AND valor_parcela < 800 THEN 1 ELSE 0 END) AS qtd_media,
        SUM(CASE WHEN valor_parcela < 500 THEN 1 ELSE 0 END)                          AS qtd_baixa
    FROM base_2020
    GROUP BY sigla_uf, ano_referencia
)
SELECT * FROM faixas_uf_ano;


--  1.6 
WITH
base_2020 AS (
    SELECT *
    FROM garantia_safra
    WHERE ano_referencia >= 2020
),
totais_uf_ano AS (
    SELECT
        sigla_uf,
        ano_referencia,
        SUM(valor_parcela) AS valor_total,
        COUNT(*)           AS qtd_parcelas
    FROM base_2020
    GROUP BY sigla_uf, ano_referencia
),
contagens_uf_ano AS (
    SELECT
        sigla_uf,
        ano_referencia,
        COUNT(DISTINCT nis_favorecido) AS beneficiarios_unicos,
        COUNT(DISTINCT id_municipio)   AS municipios_atendidos
    FROM base_2020
    GROUP BY sigla_uf, ano_referencia
),
estatisticas_uf_ano AS (
    SELECT
        sigla_uf,
        ano_referencia,
        AVG(valor_parcela) AS ticket_medio,
        MAX(valor_parcela) AS maior_valor
    FROM base_2020
    GROUP BY sigla_uf, ano_referencia
),
faixas_uf_ano AS (
    SELECT
        sigla_uf,
        ano_referencia,
        SUM(CASE WHEN valor_parcela >= 800 THEN 1 ELSE 0 END)                         AS qtd_alta,
        SUM(CASE WHEN valor_parcela >= 500 AND valor_parcela < 800 THEN 1 ELSE 0 END) AS qtd_media,
        SUM(CASE WHEN valor_parcela < 500 THEN 1 ELSE 0 END)                          AS qtd_baixa
    FROM base_2020
    GROUP BY sigla_uf, ano_referencia
)
SELECT
    t.sigla_uf,
    t.ano_referencia,
    t.valor_total,
    t.qtd_parcelas,
    c.beneficiarios_unicos,
    c.municipios_atendidos,
    ROUND(e.ticket_medio, 2) AS ticket_medio,
    e.maior_valor,
    f.qtd_alta,
    f.qtd_media,
    f.qtd_baixa,
    CASE
        WHEN e.ticket_medio >= 800 THEN 'TICKET_ALTO'
        WHEN e.ticket_medio >= 500 THEN 'TICKET_MEDIO'
        ELSE 'TICKET_BAIXO'
    END AS classificacao_ticket
FROM totais_uf_ano t
JOIN contagens_uf_ano   c ON c.sigla_uf = t.sigla_uf AND c.ano_referencia = t.ano_referencia
JOIN estatisticas_uf_ano e ON e.sigla_uf = t.sigla_uf AND e.ano_referencia = t.ano_referencia
JOIN faixas_uf_ano       f ON f.sigla_uf = t.sigla_uf AND f.ano_referencia = t.ano_referencia
ORDER BY t.ano_referencia, t.valor_total DESC;




-- EXERCÍCIO 2
  

-- 2.1 
WITH ano_2020 AS (
    SELECT *
    FROM garantia_safra
    WHERE ano_referencia = 2020
)
SELECT * FROM ano_2020;


-- 2.2 
WITH
ano_2020 AS (
    SELECT *
    FROM garantia_safra
    WHERE ano_referencia = 2020
),
valor_uf AS (
    SELECT
        sigla_uf,
        SUM(valor_parcela) AS valor_uf,
        COUNT(*)           AS qtd_parcelas
    FROM ano_2020
    GROUP BY sigla_uf
)
SELECT * FROM valor_uf;


-- 2.3 
WITH
ano_2020 AS (
    SELECT *
    FROM garantia_safra
    WHERE ano_referencia = 2020
),
beneficiarios_uf AS (
    SELECT
        sigla_uf,
        COUNT(DISTINCT nis_favorecido) AS beneficiarios
    FROM ano_2020
    GROUP BY sigla_uf
)
SELECT * FROM beneficiarios_uf;


-- 2.4 
WITH
ano_2020 AS (
    SELECT *
    FROM garantia_safra
    WHERE ano_referencia = 2020
),
municipios_uf AS (
    SELECT
        sigla_uf,
        COUNT(DISTINCT id_municipio) AS municipios
    FROM ano_2020
    GROUP BY sigla_uf
)
SELECT * FROM municipios_uf;


-- 2.5 
WITH
ano_2020 AS (
    SELECT *
    FROM garantia_safra
    WHERE ano_referencia = 2020
),
total_brasil AS (
    SELECT SUM(valor_parcela) AS total_geral
    FROM ano_2020
)
SELECT * FROM total_brasil;


-- 2.6 
WITH
ano_2020 AS (
    SELECT *
    FROM garantia_safra
    WHERE ano_referencia = 2020
),
valor_uf AS (
    SELECT
        sigla_uf,
        SUM(valor_parcela) AS valor_uf,
        COUNT(*)           AS qtd_parcelas
    FROM ano_2020
    GROUP BY sigla_uf
),
faixa_uf AS (
    SELECT
        v.sigla_uf,
        CASE
            WHEN v.valor_uf >= 20000 THEN 'ALTO'
            WHEN v.valor_uf >= 10000 THEN 'MEDIO'
            ELSE 'BAIXO'
        END AS faixa
    FROM valor_uf v
)
SELECT * FROM faixa_uf;


-- 2.7 
WITH
ano_2020 AS (
    SELECT *
    FROM garantia_safra
    WHERE ano_referencia = 2020
),
valor_uf AS (
    SELECT
        sigla_uf,
        SUM(valor_parcela) AS valor_uf,
        COUNT(*)           AS qtd_parcelas
    FROM ano_2020
    GROUP BY sigla_uf
),
top5_uf AS (
    SELECT sigla_uf, valor_uf
    FROM valor_uf
    ORDER BY valor_uf DESC
    LIMIT 5
)
SELECT * FROM top5_uf;


-- 2.8 
WITH
ano_2020 AS (
    SELECT *
    FROM garantia_safra
    WHERE ano_referencia = 2020
),
valor_uf AS (
    SELECT
        sigla_uf,
        SUM(valor_parcela) AS valor_uf,
        COUNT(*)           AS qtd_parcelas
    FROM ano_2020
    GROUP BY sigla_uf
),
beneficiarios_uf AS (
    SELECT
        sigla_uf,
        COUNT(DISTINCT nis_favorecido) AS beneficiarios
    FROM ano_2020
    GROUP BY sigla_uf
),
municipios_uf AS (
    SELECT
        sigla_uf,
        COUNT(DISTINCT id_municipio) AS municipios
    FROM ano_2020
    GROUP BY sigla_uf
),
total_brasil AS (
    SELECT SUM(valor_parcela) AS total_geral
    FROM ano_2020
),
faixa_uf AS (
    SELECT
        v.sigla_uf,
        CASE
            WHEN v.valor_uf >= 20000 THEN 'ALTO'
            WHEN v.valor_uf >= 10000 THEN 'MEDIO'
            ELSE 'BAIXO'
        END AS faixa
    FROM valor_uf v
),
top5_uf AS (
    SELECT sigla_uf, valor_uf
    FROM valor_uf
    ORDER BY valor_uf DESC
    LIMIT 5
)
SELECT
    v.sigla_uf,
    v.valor_uf,
    v.qtd_parcelas,
    b.beneficiarios,
    m.municipios,
    ROUND(v.valor_uf * 100.0 / tb.total_geral, 2) AS participacao_pct,
    f.faixa,
    CASE
        WHEN v.valor_uf = (SELECT MAX(valor_uf) FROM valor_uf) THEN 'LIDER_BR'
        ELSE 'TOP_5'
    END AS grupo_destaque
FROM top5_uf t5
JOIN valor_uf         v ON v.sigla_uf = t5.sigla_uf
JOIN beneficiarios_uf b ON b.sigla_uf = v.sigla_uf
JOIN municipios_uf    m ON m.sigla_uf = v.sigla_uf
JOIN faixa_uf         f ON f.sigla_uf = v.sigla_uf
CROSS JOIN total_brasil tb
ORDER BY v.valor_uf DESC;




-- EXERCÍCIO 3
  

-- 3.1 
WITH base_2020 AS (
    SELECT *
    FROM garantia_safra
    WHERE ano_referencia >= 2020
)
SELECT * FROM base_2020;


-- 3.2 
WITH
base_2020 AS (
    SELECT *
    FROM garantia_safra
    WHERE ano_referencia >= 2020
),
beneficiario_totais AS (
    SELECT
        sigla_uf,
        id_municipio,
        ano_referencia,
        nis_favorecido,
        nome_favorecido,
        SUM(valor_parcela) AS total_recebido,
        AVG(valor_parcela) AS media_parcela,
        COUNT(*)           AS qtd_parcelas
    FROM base_2020
    GROUP BY sigla_uf, id_municipio, ano_referencia, nis_favorecido, nome_favorecido
)
SELECT * FROM beneficiario_totais;


-- 3.3 
WITH
base_2020 AS (
    SELECT *
    FROM garantia_safra
    WHERE ano_referencia >= 2020
),
municipio_totais AS (
    SELECT
        sigla_uf,
        id_municipio,
        ano_referencia,
        SUM(valor_parcela) AS total_municipio
    FROM base_2020
    GROUP BY sigla_uf, id_municipio, ano_referencia
)
SELECT * FROM municipio_totais;


-- 3.4 
WITH
base_2020 AS (
    SELECT *
    FROM garantia_safra
    WHERE ano_referencia >= 2020
),
beneficiario_totais AS (
    SELECT
        sigla_uf,
        id_municipio,
        ano_referencia,
        nis_favorecido,
        nome_favorecido,
        SUM(valor_parcela) AS total_recebido,
        AVG(valor_parcela) AS media_parcela,
        COUNT(*)           AS qtd_parcelas
    FROM base_2020
    GROUP BY sigla_uf, id_municipio, ano_referencia, nis_favorecido, nome_favorecido
),
maior_beneficiario_municipio AS (
    SELECT
        sigla_uf,
        id_municipio,
        ano_referencia,
        MAX(total_recebido) AS maior_total_individual
    FROM beneficiario_totais
    GROUP BY sigla_uf, id_municipio, ano_referencia
)
SELECT * FROM maior_beneficiario_municipio;


-- 3.5 
WITH
base_2020 AS (
    SELECT *
    FROM garantia_safra
    WHERE ano_referencia >= 2020
),
beneficiario_totais AS (
    SELECT
        sigla_uf,
        id_municipio,
        ano_referencia,
        nis_favorecido,
        nome_favorecido,
        SUM(valor_parcela) AS total_recebido,
        AVG(valor_parcela) AS media_parcela,
        COUNT(*)           AS qtd_parcelas
    FROM base_2020
    GROUP BY sigla_uf, id_municipio, ano_referencia, nis_favorecido, nome_favorecido
),
faixa_beneficiario AS (
    SELECT
        sigla_uf,
        id_municipio,
        ano_referencia,
        nis_favorecido,
        CASE
            WHEN total_recebido >= 800 THEN 'ALTO'
            WHEN total_recebido >= 500 THEN 'MEDIO'
            ELSE 'BAIXO'
        END AS faixa
    FROM beneficiario_totais
)
SELECT * FROM faixa_beneficiario;


-- 3.6 
WITH
base_2020 AS (
    SELECT *
    FROM garantia_safra
    WHERE ano_referencia >= 2020
),
beneficiario_totais AS (
    SELECT
        sigla_uf,
        id_municipio,
        ano_referencia,
        nis_favorecido,
        nome_favorecido,
        SUM(valor_parcela) AS total_recebido,
        AVG(valor_parcela) AS media_parcela,
        COUNT(*)           AS qtd_parcelas
    FROM base_2020
    GROUP BY sigla_uf, id_municipio, ano_referencia, nis_favorecido, nome_favorecido
),
municipio_totais AS (
    SELECT
        sigla_uf,
        id_municipio,
        ano_referencia,
        SUM(valor_parcela) AS total_municipio
    FROM base_2020
    GROUP BY sigla_uf, id_municipio, ano_referencia
),
maior_beneficiario_municipio AS (
    SELECT
        sigla_uf,
        id_municipio,
        ano_referencia,
        MAX(total_recebido) AS maior_total_individual
    FROM beneficiario_totais
    GROUP BY sigla_uf, id_municipio, ano_referencia
),
faixa_beneficiario AS (
    SELECT
        sigla_uf,
        id_municipio,
        ano_referencia,
        nis_favorecido,
        CASE
            WHEN total_recebido >= 800 THEN 'ALTO'
            WHEN total_recebido >= 500 THEN 'MEDIO'
            ELSE 'BAIXO'
        END AS faixa
    FROM beneficiario_totais
)
SELECT
    bt.sigla_uf,
    bt.id_municipio,
    bt.ano_referencia,
    bt.nis_favorecido,
    bt.nome_favorecido,
    bt.total_recebido,
    ROUND(bt.media_parcela, 2) AS media_parcela,
    bt.qtd_parcelas,
    mt.total_municipio,
    ROUND(bt.total_recebido * 100.0 / mt.total_municipio, 2) AS participacao_pct,
    mb.maior_total_individual,
    fb.faixa,
    CASE
        WHEN bt.total_recebido = mb.maior_total_individual THEN 'DESTAQUE_MUNICIPAL'
        ELSE 'OUTROS'
    END AS grupo_destaque
FROM beneficiario_totais bt
JOIN municipio_totais mt
    ON mt.sigla_uf = bt.sigla_uf AND mt.id_municipio = bt.id_municipio AND mt.ano_referencia = bt.ano_referencia
JOIN maior_beneficiario_municipio mb
    ON mb.sigla_uf = bt.sigla_uf AND mb.id_municipio = bt.id_municipio AND mb.ano_referencia = bt.ano_referencia
JOIN faixa_beneficiario fb
    ON fb.sigla_uf = bt.sigla_uf AND fb.id_municipio = bt.id_municipio
   AND fb.ano_referencia = bt.ano_referencia AND fb.nis_favorecido = bt.nis_favorecido
ORDER BY bt.sigla_uf, bt.id_municipio, bt.ano_referencia, bt.total_recebido DESC;