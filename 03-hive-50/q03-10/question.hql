-- 
-- Pregunta
-- ===========================================================================
--
-- Para resolver esta pregunta use el archivo `data.tsv`.
--
-- Escriba una consulta que devuelva los cinco valores diferentes más pequeños 
-- de la tercera columna.
--
-- Escriba el resultado a la carpeta `output` de directorio de trabajo.
--
-- >>> Escriba su respuesta a partir de este punto <<<
--
!hdfs dfs -rm -r -f /tmp/output;
!hdfs dfs -rm -r -f /tmp/datos;
!hdfs dfs -mkdir /tmp/datos;
!hdfs dfs -mkdir /tmp/output;
!hadoop fs -copyFromLocal data.tsv  /tmp/datos/;


DROP TABLE IF EXISTS datos;

CREATE TABLE datos (
    col1    STRING,
    col2    STRING,
    col3    INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t';

LOAD DATA INPATH '/tmp/datos/data.tsv' OVERWRITE INTO TABLE datos;

INSERT OVERWRITE DIRECTORY '/tmp/output/'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','

SELECT DISTINCT(col3)
FROM datos
ORDER BY col3 ASC
LIMIT 5;


!hadoop fs -copyToLocal /tmp/output output;