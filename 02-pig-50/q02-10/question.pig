-- Pregunta
-- ===========================================================================
-- 
-- Ordene el archivo `data.tsv`  por letra y valor (3ra columna).
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
-- 
--  >>> Escriba el codigo del mapper a partir de este punto <<<
-- 
-- subimos el archivo a HDFS
fs -put -f data.tsv

-- carga de datos
lines = LOAD '*.tsv' 
    AS (col1:CHARARRAY,
        col2:CHARARRAY,
        col3:INT);

    
grouped =  GROUP lines BY col1;

-- agrupa los registros que tienen la misma palabra
ordered = FOREACH grouped {
            s = ORDER lines BY $2 ASC;
            GENERATE FLATTEN (s);
          };

-- v = FOREACH ordered GENERATE $0, CONCAT($1,'/t'), $2;
v = FOREACH ordered GENERATE $0, $1, $2;
-- DUMP v;

-- escribe el archivo de salida
STORE v INTO 'output';

-- copia los archivos del HDFS al sistema local
fs -get -f output/ .


