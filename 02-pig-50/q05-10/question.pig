-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para el archivo `data.tsv` compute Calcule la cantidad de registros en que 
-- aparece cada letra minúscula en la columna 2.
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
        col3:CHARARRAY);

    
-- genera una tabla llamada words con una palabra por registro
columna = FOREACH lines GENERATE FLATTEN(TOKENIZE(col2)) AS letra;

-- agrupa los registros que tienen la misma palabra
grouped = GROUP columna BY letra;

-- v = FOREACH grouped GENERATE group, REPLACE(columna, '[{()}]', '');

-- genera una variable que cuenta las ocurrencias por cada grupo
abc_count = FOREACH grouped GENERATE group, COUNT(columna);


w = STREAM abc_count THROUGH  `head -n -2 `;

-- DUMP w;

-- escribe el archivo de salida
STORE w INTO 'output';

-- copia los archivos del HDFS al sistema local
fs -get -f output/ .
