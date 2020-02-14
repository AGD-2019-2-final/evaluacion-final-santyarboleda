-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para el archivo `data.tsv` Calcule la cantidad de registros por clave de la 
-- columna 3. En otras palabras, cuántos registros hay que tengan la clave 
-- `aaa`?
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
        col2:CHARARRAY,
        col3:MAP[]);

-- generamos una columna con las claves del campo map
columna2 = FOREACH lines GENERATE KEYSET(col3) AS maps;
columna3 = FOREACH columna2 GENERATE FLATTEN(maps) AS maps2;

-- agrupa los registros que tienen la misma palabra
grouped = GROUP columna3 BY maps2;

-- genera una variable que cuenta las ocurrencias por cada grupo
abc_count = FOREACH grouped GENERATE group, COUNT(columna3);

-- DUMP abc_count;

-- escribe el archivo de salida
STORE abc_count INTO 'output' USING PigStorage(',');

-- copia los archivos del HDFS al sistema local
fs -get -f output/ .