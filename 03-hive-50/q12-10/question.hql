-- 
-- Pregunta
-- ===========================================================================
--
-- Escriba una consulta que compute la cantidad de registros por letra de la 
-- columna 2 y clave de la columna 3; esto es, por ejemplo, la cantidad de 
-- registros en tienen la letra `a` en la columna 2 y la clave `aaa` en la 
-- columna 3 es:
--
--     a    aaa    5
--
-- Escriba el resultado a la carpeta `output` de directorio de trabajo.
--
DROP TABLE IF EXISTS t0;
CREATE TABLE t0 (
    c1 STRING,
    c2 ARRAY<CHAR(1)>, 
    c3 MAP<STRING, INT>
    )
    ROW FORMAT DELIMITED 
        FIELDS TERMINATED BY '\t'
        COLLECTION ITEMS TERMINATED BY ','
        MAP KEYS TERMINATED BY '#'
        LINES TERMINATED BY '\n';
LOAD DATA LOCAL INPATH 'data.tsv' INTO TABLE t0;
--
-- >>> Escriba su respuesta a partir de este punto <<<
--
!hdfs dfs -rm -r -f /tmp/output;

INSERT OVERWRITE DIRECTORY '/tmp/output/'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
SELECT col2, key, COUNT(col2)
FROM (    
    SELECT exploded_table.col AS col2, t0.c3
    FROM t0
    LATERAL VIEW explode (c2) exploded_table) t 
LATERAL VIEW explode (c3) exploded_table

GROUP BY col2, key;

!hadoop fs -copyToLocal /tmp/output output;