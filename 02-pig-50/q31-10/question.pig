-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para responder la pregunta use el archivo `data.csv`.
-- 
-- Cuente la cantidad de personas nacidas por año.
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
        birthday:DATETIME, 
        color:CHARARRAY, 
        quantity:INT);
--
-- >>> Escriba su respuesta a partir de este punto <<<
--
v = FOREACH u GENERATE ToString($3, 'YYYY');

grouped = GROUP v BY $0;

conteo = FOREACH grouped GENERATE group, COUNT(v);

-- DUMP conteo; 

-- escribe el archivo de salida
STORE conteo INTO 'output' USING PigStorage(',');

-- copia los archivos del HDFS al sistema local
fs -get -f output/ .  