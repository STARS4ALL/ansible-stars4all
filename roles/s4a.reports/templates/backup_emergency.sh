#!/bin/bash

# Emergency backup as source files (excep readings)
# ASSUME WE HAVE PASUED tessdb MANUALLY

DEFAULT_DATABASE="/var/dbase/tess.db"
DEFAULT_BACKUP_DIR="/home/pi/backup"

# Arguments from the command line & default values

# Either the default or the rotated tess.db-* database
dbase="${1:-$DEFAULT_DATABASE}"
# wildcard expansion ...
dbase="$(ls -1 $dbase)"

out_dir="${2:-$DEFAULT_BACKUP_DIR}"


if  [[ ! -f $dbase || ! -r $dbase ]]; then
        echo "Database file $dbase does not exists or is not readable."
        echo "Exiting"
        exit 1
fi

if  [[ ! -d $out_dir  ]]; then
        echo "Backup directory $out_dir does not exists."
        echo "Exiting"
        exit 1
fi

sqlite3 ${dbase} <<EOF
.output ${out_dir}/schema.sql
.schema
.output ${out_dir}/date.sql
.dump date_t
.output ${out_dir}/time.sql
.dump time_t
.output ${out_dir}/location.sql
.dump location_t
.output ${out_dir}/tess.sql
.dump tess_t
.output ${out_dir}/tess_units.sql
.dump tess_units_t
.quit
EOF

