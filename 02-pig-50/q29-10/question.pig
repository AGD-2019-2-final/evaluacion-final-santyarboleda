-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para responder la pregunta use el archivo `data.csv`.
-- 
-- Escriba el código en Pig para manipulación de fechas que genere la siguiente 
-- salida.
-- 
--    1971-07-08,jul,07,7
--    1974-05-23,may,05,5
--    1973-04-22,abr,04,4
--    1975-01-29,ene,01,1
--    1974-07-03,jul,07,7
--    1974-10-18,oct,10,10
--    1970-10-05,oct,10,10
--    1969-02-24,feb,02,2
--    1974-10-17,oct,10,10
--    1975-02-28,feb,02,2
--    1969-12-07,dic,12,12
--    1973-12-24,dic,12,12
--    1970-08-27,ago,08,8
--    1972-12-12,dic,12,12
--    1970-07-01,jul,07,7
--    1974-02-11,feb,02,2
--    1973-04-01,abr,04,4
--    1973-04-29,abr,04,4
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
w = FOREACH u GENERATE ToString($3, 'YYYY-MM-dd'), (CASE LOWER(ToString($3, 'MMM'))
                                                            WHEN 'jan' THEN 'ene'
                                                            WHEN 'feb' THEN 'feb'
                                                            WHEN 'mar' THEN 'mar'
                                                            WHEN 'apr' THEN 'abr'
                                                            WHEN 'may' THEN 'may'
                                                            WHEN 'jun' THEN 'jun'
                                                            WHEN 'jul' THEN 'jul'
                                                            WHEN 'aug' THEN 'ago'
                                                            WHEN 'sep' THEN 'sep'
                                                            WHEN 'oct' THEN 'oct'
                                                            WHEN 'nov' THEN 'nov'
                                                            ELSE 'dic'                                                  
                                                        
                                                        END                                             
                                                                  
                                                       ), ToString($3, 'MM'), ToString($3, 'M');

-- escribe el archivo de salida
STORE w INTO 'output' USING PigStorage(',');

-- copia los archivos del HDFS al sistema local
fs -get -f output/ . 