-- 
-- Pregunta
-- ===========================================================================
--
-- Para resolver esta pregunta use el archivo `data.tsv`.
--
-- Compute la cantidad de registros por cada letra de la columna 1.
-- Escriba el resultado ordenado por letra. 
--
-- Escriba el resultado a la carpeta `output` de directorio de trabajo.
--
-- >>> Escriba su respuesta a partir de este punto <<<
--
-- Copia el archivo al HDFS para su importación posterior a Hive
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

SELECT col1, COUNT(col3)
FROM datos
GROUP BY col1;


!hadoop fs -copyToLocal /tmp/output output;