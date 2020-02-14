-- Pregunta
-- ===========================================================================
-- 
-- Para el archivo `data.csv` escriba una consulta en Pig que genere la 
-- siguiente salida:
-- 
--   Vivian@Hamilton
--   Karen@Holcomb
--   Cody@Garrett
--   Roth@Fry
--   Zoe@Conway
--   Gretchen@Kinney
--   Driscoll@Klein
--   Karyn@Diaz
--   Merritt@Guy
--   Kylan@Sexton
--   Jordan@Estes
--   Hope@Coffey
--   Vivian@Crane
--   Clio@Noel
--   Hope@Silva
--   Ayanna@Jarvis
--   Chanda@Boyer
--   Chadwick@Knight
-- 
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
--
-- subimos el archivo a HDFS
fs -put -f data.csv

-- carga de datos
lines = LOAD 'data.csv' USING PigStorage(',')
    AS (col1:INT,
        col2:CHARARRAY,
        col3:CHARARRAY,
        col4:CHARARRAY,
        col5:CHARARRAY,
        col6:INT);
    
v = FOREACH lines GENERATE CONCAT($1, '@', $2);

-- escribe el archivo de salida
STORE v INTO 'output';

-- copia los archivos del HDFS al sistema local
fs -get -f output/ .


