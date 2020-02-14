-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para el archivo `data.tsv` compute la cantidad de registros por letra. 
-- Escriba el resultado a la carpeta `output` del directorio actual.
--
fs -rm -f -r output;
--rmf $pwd/output
--%declare OutputFile '/home/LocalPig/test'

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

-- genera una tabla llamada letras con la columna 1
letras = FOREACH lines GENERATE col1 AS letra;

-- agrupa los registros que tienen la misma palabra
grouped = GROUP letras BY letra;

-- genera una variable que cuenta las ocurrencias por cada grupo
count = FOREACH grouped GENERATE group, COUNT(letras);

-- escribe el archivo de salida
STORE count INTO 'output';

-- copia los archivos del HDFS al sistema local
fs -get -f output/ .
