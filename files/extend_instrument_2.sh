#!/bin/bash

# This scrits adds two new columns 'contact_name' and 'timezone'
# to the location_te table

service tessdb pause ; sleep 2

sqlite3 /var/dbase/tess.db <<EOF
.mode column
.headers on
BEGIN TRANSACTION;


ALTER TABLE tess_t ADD COLUMN azimuth  REAL    DEFAULT  0.0;
ALTER TABLE tess_t ADD COLUMN altitude REAL    DEFAULT  90.0;

DROP VIEW tess_v;
CREATE VIEW tess_v 
        AS SELECT
            tess_t.tess_id,
            tess_t.name,
            tess_t.channel,
            tess_t.model,
            tess_t.firmware,
            tess_t.mac_address,
            tess_t.zero_point,
            tess_t.cover_offset,
            tess_t.filter,
            tess_t.fov,
            tess_t.azimuth,
            tess_t.altitude,
            tess_t.valid_since,
            tess_t.valid_until,
            tess_t.valid_state,
            location_t.contact_name,
            location_t.organization,
            location_t.contact_email,
            location_t.site,
            location_t.longitude,
            location_t.latitude,
            location_t.elevation,
            location_t.zipcode,
            location_t.location,
            location_t.province,
            location_t.country,
            location_t.timezone
        FROM tess_t JOIN location_t USING (location_id);

COMMIT;
EOF

service tessdb resume
