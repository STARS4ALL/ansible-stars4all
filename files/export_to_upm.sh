#!/bin/bash
# {{ ansible_managed }}

DEFAULT_DATABASE="/var/dbase/tess.db"
DEFAULT_REPORTS_DIR="/var/dbase/reports"
DEFAULT_START_DATE="2020-05-05T07:20:00"
DEFAULT_END_DATE="2020-05-06T06:12:00"

# Arguments from the command line & default values

start_date="${1:-$DEFAULT_START_DATE}"
end_date="${2:-$DEFAULT_END_DATE}"

# Either the default or the rotated tess.db-* database
dbase="${3:-$DEFAULT_DATABASE}"
# wildcard expansion ...
dbase="$(ls -1 $dbase)"

out_dir="${4:-$DEFAULT_REPORTS_DIR}"
# get the name from the script name without extensions

# exported file name drived from script name
name=$(basename ${0%.sh})


if  [[ ! -f $dbase || ! -r $dbase ]]; then
        echo "Database file $dbase does not exists or is not readable."
        echo "Exiting"
        exit 1
fi

if  [[ ! -d $out_dir  ]]; then
        echo "Output directory $out_dir does not exists."
        echo "Exiting"
        exit 1
fi


sqlite3 -csv -header ${dbase} <<EOF > ${out_dir}/${name}_${start_date}_${end_date}.csv
.separator ;
SELECT (d.sql_date || 'T' || t.time) AS timestamp, 
(SELECT name FROM name_to_mac_t WHERE mac_address ==  i.mac_address) AS name,
r.frequency           AS frequency, 
r.magnitude           AS magnitude,
r.sky_temperature     AS tsky, 
r.ambient_temperature AS tamb,
r.signal_strength     AS wdBm
FROM tess_readings_t AS r
JOIN date_t     as d USING (date_id)
JOIN time_t     as t USING (time_id)
JOIN tess_t     as i USING (tess_id)
WHERE timestamp BETWEEN "${start_date}" AND "${end_date}"
ORDER BY r.date_id DESC, r.time_id DESC;
EOF

