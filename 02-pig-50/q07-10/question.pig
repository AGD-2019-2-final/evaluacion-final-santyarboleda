-- Pregunta
-- ===========================================================================
-- 
-- Para el archivo `data.tsv` genere una tabla que contenga la primera columna,
-- la cantidad de elementos en la columna 2 y la cantidad de elementos en la 
-- columna 3 separados por coma. La tabla debe estar ordenada por las 
-- columnas 1, 2 y 3.
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
        col2:BAG{t:TUPLE(p:CHARARRAY)},
        col3:MAP[]);
    
-- generamos una columna con las claves del campo map
columnas = FOREACH lines GENERATE col1, col2, KEYSET(col3) AS cols;
columnas2 = FOREACH columnas GENERATE col1 AS ncol1, SIZE(col2) AS ncol2, SIZE(cols) AS ncol3 ;

ordered = ORDER columnas2 BY ncol1,ncol2,ncol3;

-- escribe el archivo de salida
STORE ordered INTO 'output' USING PigStorage(',');

-- copia los archivos del HDFS al sistema local
fs -get -f output/ .