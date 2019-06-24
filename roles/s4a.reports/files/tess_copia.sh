#!/bin/bash

# VARIABLES DE CONFIGURACION
USER=pi
HOST=rb-tess.fis.ucm.es
SRCDIR=/var/dbase/reports
DATADIR=$HOME/tess_data
SUMMARY_FILE=tess_readings_daily_summary.txt
CATALOG_FILES=tess_c*.csv
DATA_FILES=*.csv.gz


# CREA EL DIRECTORIO LOCAL DE DATOS COPIADOS
[ ! -f $DATADIR ] && mkdir -p $DATADIR

# REALIZA LA COPIA
echo "Copiando datos exportados de TESSSD a ${DATADIR}"
scp ${USER}@${HOST}:${SRCDIR}/${SUMMARY_FILE}  ${DATADIR}
scp ${USER}@${HOST}:${SRCDIR}/${CATALOG_FILES} ${DATADIR}
scp ${USER}@${HOST}:${SRCDIR}/${DATA_FILES}    ${DATADIR}
echo "Hecho"
