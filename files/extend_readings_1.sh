#!/bin/bash

# This script adds two new columns 'signal_strength' and 'signal_strength_units'
# to the tess_readings_t & tess_units_t tables

sudo service tessdb pause ; sleep 2

sudo sqlite3 /var/dbase/tess.db <<EOF
.mode column
.headers on
BEGIN TRANSACTION;

ALTER TABLE tess_readings_t ADD COLUMN signal_strength       INTEGER;
ALTER TABLE tess_units_t    ADD COLUMN signal_strength_units TEXT;

UPDATE tess_units_t SET signal_strength_units = "dBm";

COMMIT;
EOF

sudo service tessdb resume
