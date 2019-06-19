#!/bin/bash

# This scrits rename the default acronym of 'DG' to UVIR
# we have to recreate the table, since the default value for 
# the 'filter' column is set to 'DG'

service tessdb pause ; sleep 1

sqlite3 /var/dbase/tess.db <<EOF
.mode column
.headers on
BEGIN TRANSACTION;

UPDATE tess_t
SET filter = 'UVIR'
WHERE filter = 'DG';

UPDATE tess_t
SET filter = 'UVIR+BG39'
WHERE filter = 'DG+BG39';

UPDATE tess_t
SET filter = 'UVIR+GG495'
WHERE filter = 'DG+GG495';

COMMIT;

BEGIN TRANSACTION;

DROP VIEW tess_v;
DROP INDEX tess_name_i;
DROP INDEX tess_mac_i;

ALTER TABLE tess_t RENAME TO tess_old_t;
CREATE TABLE IF NOT EXISTS tess_t
    (
        tess_id       INTEGER PRIMARY KEY AUTOINCREMENT,
        name          TEXT,
        mac_address   TEXT, 
        zero_point    REAL,
        filter        TEXT DEFAULT 'UVIR',
        valid_since   TEXT,
        valid_until   TEXT,
        valid_state   TEXT,
        location_id   INTEGER NOT NULL DEFAULT -1 REFERENCES location_t(location_id)
    );

INSERT INTO tess_t SELECT * from tess_old_t;
DROP TABLE tess_old_t;

CREATE INDEX tess_name_i ON tess_t(name);
CREATE INDEX tess_mac_i ON tess_t(mac_address);
CREATE VIEW tess_v 
AS SELECT
    tess_t.tess_id,
    tess_t.name,
    tess_t.mac_address,
    tess_t.zero_point,
    tess_t.filter,
    tess_t.valid_since,
    tess_t.valid_until,
    tess_t.valid_state,
    location_t.contact_email,
    location_t.site,
    location_t.longitude,
    location_t.latitude,
    location_t.elevation,
    location_t.zipcode,
    location_t.location,
    location_t.province,
    location_t.country
FROM tess_t JOIN location_t USING (location_id);

COMMIT;
EOF

service tessdb resume
