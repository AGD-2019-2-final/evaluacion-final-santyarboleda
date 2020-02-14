-- 
-- Pregunta
-- ===========================================================================
--
-- Para resolver esta pregunta use el archivo `data.tsv`.
--
-- Construya una consulta que ordene la tabla por letra y valor (3ra columna).
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

SELECT *
FROM datos
ORDER BY col1, col3, col2;


!hadoop fs -copyToLocal /tmp/output output;