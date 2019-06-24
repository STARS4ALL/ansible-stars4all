#!/bin/bash
# {{ ansible_managed }}

DEFAULT_DATABASE="/var/dbase/tess.db"
DEFAULT_REPORTS_DIR="/var/dbase/reports"

# Arguments from the command line & default values

# Either the default or the rotated tess.db-* database
dbase="${1:-$DEFAULT_DATABASE}"
# wildcard expansion ...
dbase="$(ls -1 $dbase)"

out_dir="${2:-$DEFAULT_REPORTS_DIR}"
# get the name from the script name without extensions
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

dbname=$(basename $dbase)
oper_dbname=$(basename $DEFAULT_DATABASE)

if [[ "$dbname" = "$oper_dbname" ]]; then
    operational_dbase="yes"
else
    operational_dbase="no"
fi

# Stops background database I/O when using the operational database
if  [[ $operational_dbase = "yes" ]]; then
        echo "Pausing tessdb service."
    	/usr/local/bin/tessdb_pause 
		/bin/sleep 2
else
	echo "Using backup database, no need to pause tessdb service."
fi


sqlite3 -csv -header ${dbase} <<EOF > ${out_dir}/${name}.csv
.separator ;
SELECT i.name AS Name, i.tess_id as Id, i.zero_point as ZP, i.filter as Filter, i.authorised as Enabled, i.registered as Registered, i.valid_since AS Since, i.valid_until AS Until, i.valid_state AS 'Change State'
FROM tess_t AS i
ORDER BY CAST(substr(i.name, 6) as decimal) ASC, i.valid_since ASC;
EOF


# Resume background database I/O
if  [[ $operational_dbase = "yes" ]]; then
        echo "Resuming tessdb service."
    	/usr/local/bin/tessdb_resume
else
	echo "Using backup database, no need to resume tessdb service."
fi