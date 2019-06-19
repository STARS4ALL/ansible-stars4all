#!/bin/bash

# Migra las medidas tomadas a partir del 20160909
# de Villaverde del Ducado a la UCM

service tessdb pause ; sleep 1

sqlite3 /var/dbase/tess.db <<EOF
.mode column
.headers on

SELECT i.name, r.tess_id, r.location_id, COUNT(r.location_id) as muestras
FROM tess_readings_t as r
JOIN tess_t          AS i USING (tess_id)
WHERE i.name = "stars4"
GROUP BY r.tess_id, r.location_id;

UPDATE tess_readings_t
SET location_id = 3
WHERE date_id >= 20160909
AND tess_id = 10;

SELECT i.name, r.tess_id, r.location_id, COUNT(r.location_id) as muestras
FROM tess_readings_t as r
JOIN tess_t          AS i USING (tess_id)
WHERE i.name = "stars4"
GROUP BY r.tess_id, r.location_id;

EOF
