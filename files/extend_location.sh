#!/bin/bash

# This script adds two new columns 'contact_name' and 'timezone'
# to the location_te table

service tessdb pause ; sleep 2

sqlite3 /var/dbase/tess.db <<EOF
.mode column
.headers on
BEGIN TRANSACTION;

ALTER TABLE location_t ADD COLUMN contact_name TEXT DEFAULT 'Unknown';
ALTER TABLE location_t ADD COLUMN timezone     TEXT DEFAULT 'Etc/UTC';
ALTER TABLE location_t ADD COLUMN organization TEXT DEFAULT 'Unknown';

COMMIT;
EOF

service tessdb resume
