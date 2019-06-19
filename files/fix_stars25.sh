#!/bin/bash

# stars25 was not in service despite being in the database
# The old hardware was fried so we reuse the name 
# for a new photometer

service tessdb pause ; sleep 1

sqlite3 /var/dbase/tess.db <<EOF
.mode column
.headers on
BEGIN TRANSACTION;

UPDATE tess_t
SET filter = 'UVIR', mac_address = '1A:FE:34:D3:43:A8', zero_point = 20.41
WHERE name = 'stars25';

COMMIT;

EOF

service tessdb resume
