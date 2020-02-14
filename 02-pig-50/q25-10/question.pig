-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para responder la pregunta use el archivo `data.csv`.
-- 
-- Escriba el código equivalente a la siguiente consulta SQL.
-- 
--    SELECT  
--        firstname,
--        SUBSTRING_INDEX(firstname, 'a', 1)
--    FROM 
--        u;
-- 
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
-- subimos el archivo a HDFS
fs -put -f data.csv
-- 
u = LOAD 'data.csv' USING PigStorage(',') 
    AS (id:int, 
        firstname:CHARARRAY, 
        surname:CHARARRAY, 
        birthday:CHARARRAY, 
        color:CHARARRAY, 
        quantity:INT);
--
-- >>> Escriba su respuesta a partir de este punto <<<
--
v = FOREACH u GENERATE INDEXOF($1, 'a', 1);

-- escribe el archivo de salida
STORE v INTO 'output';

-- copia los archivos del HDFS al sistema local
fs -get -f output/ .
