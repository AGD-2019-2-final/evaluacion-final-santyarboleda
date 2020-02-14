-- Pregunta
-- ===========================================================================
-- 
-- Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
-- columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
-- registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
-- columna 3 es:
-- 
--   ((b,jjj), 216)
-- 
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
--
-- >>> Escriba su respuesta a partir de este punto <<<
--
-- subimos el archivo a HDFS
fs -put -f data.tsv

-- carga de datos
lines = LOAD '*.tsv' 
    AS (col1:CHARARRAY,
        col2:BAG{t:(p:CHARARRAY)},
        col3:MAP[]);
    

columna = FOREACH lines GENERATE FLATTEN(col2), FLATTEN(KEYSET(col3));

ordered = ORDER columna BY $0 ASC,$1 ASC;

--
grouped = GROUP ordered BY ($0,$1);
conteo = FOREACH grouped GENERATE group, COUNT(ordered);
--


--DUMP conteo;

-- escribe el archivo de salida
STORE conteo INTO 'output';

-- copia los archivos del HDFS al sistema local
fs -get -f output/ .