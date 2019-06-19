#!/bin/bash

# This script adds two new columns 'signal_strength' and 'signal_strength_units'
# to the tess_readings_t & tess_units_t tables

sudo tessdb_pause ; sleep 2

sudo sqlite3 /var/dbase/tess.db <<EOF
.mode column
.headers on
BEGIN TRANSACTION;

ALTER TABLE tess_units_t ADD COLUMN reading_source TEXT;

UPDATE tess_units_t SET reading_source = "Direct";

INSERT INTO tess_units_t (
                units_id,
                frequency_units,
                magnitude_units,
                ambient_temperature_units,
                sky_temperature_units,
                azimuth_units,
                altitude_units,
                longitude_units,
                latitude_units,
                height_units,
                signal_strength_units,
                timestamp_source,
                reading_source,
                valid_since,
                valid_until,
                valid_state
            ) VALUES (
                2,
                "Hz",
                "Mv/arcsec^2",
                "deg. C",
                "deg. C",
                "degrees",
                "degrees",
                "degrees",
                "degrees",
                "m",
                "dBm",
                "Subscriber",
                "Imported",
                "2016-01-01T00:00:00",
                "2999-12-31T23:59:59",
                "Current"
            ),
            (
                3,
                "Hz",
                "Mv/arcsec^2",
                "deg. C",
                "deg. C",
                "degrees",
                "degrees",
                "degrees",
                "degrees",
                "m",
                "dBm",
                "Publisher",
                "Imported",
                "2016-01-01T00:00:00",
                "2999-12-31T23:59:59",
                "Current"
             );
EOF

sudo tessdb_resume
