--
-- Pregunta
-- ===========================================================================
-- 
-- El archivo `truck_event_text_partition.csv` tiene la siguiente estructura:
-- 
--   driverId       INT
--   truckId        INT
--   eventTime      STRING
--   eventType      STRING
--   longitude      DOUBLE
--   latitude       DOUBLE
--   eventKey       STRING
--   correlationId  STRING
--   driverName     STRING
--   routeId        BIGINT
--   routeName      STRING
--   eventDate      STRING
-- 
-- Escriba un script en Pig que carge los datos y obtenga los primeros 10 
-- registros del archivo para las primeras tres columnas, y luego, ordenados 
-- por driverId, truckId, y eventTime. 
--
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
-- 
--  >>> Escriba su respuesta a partir de este punto <<<
-- 
-- subimos el archivo a HDFS
fs -put -f truck_event_text_partition.csv

-- carga de datos
lines = LOAD 'truck_event_text_partition.csv' USING PigStorage(',') 
    AS (driverId:INT, 
        truckId:INT, 
        eventTime:CHARARRAY, 
        eventType:CHARARRAY, 
        longitude:DOUBLE, 
        latitude:DOUBLE, 
        eventKey:CHARARRAY,
        correlationId:CHARARRAY, 
        driverName:CHARARRAY, 
        routeId:LONG, 
        routeName:CHARARRAY, 
        eventDate:CHARARRAY);

-- DUMP lines;
    
    
v = FOREACH lines GENERATE $0, $1, $2;
-- DUMP v;

-- selecciona las primeras 10 palabras
s = LIMIT v 10;

grouped =  GROUP s BY ($0,$1);

-- agrupa los registros que tienen la misma palabra
ordered = FOREACH grouped {
            t = ORDER s BY $2 ASC;
            GENERATE FLATTEN (t);
          };

-- agrupa los registros que tienen la misma palabra
-- ordered2 = FOREACH ordered {
--         u = ORDER ordered BY $2 ASC;
--            GENERATE FLATTEN (u);
--          };

-- DUMP ordered;

w = FOREACH ordered GENERATE $0, $1, $2;
-- w = FOREACH ordered GENERATE FLATTEN(REPLACE($0, '\t', ','));

-- escribe el archivo de salida
STORE w INTO 'output' USING PigStorage(',');

-- copia los archivos del HDFS al sistema local
fs -get -f output/ .