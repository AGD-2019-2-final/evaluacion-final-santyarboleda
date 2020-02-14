-- Pregunta
-- ===========================================================================
-- 
-- Obtenga los cinco (5) valores más pequeños de la 3ra columna.
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
        col3:INT);

    
ordered =  ORDER lines BY col3;

v = FOREACH ordered GENERATE $2;

-- selecciona las primeras 5 palabras
s = LIMIT v 5;

-- escribe el archivo de salida
STORE s INTO 'output';

-- copia los archivos del HDFS al sistema local
fs -get -f output/ .