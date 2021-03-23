#!/bin/sh

# Specify DOMAIN and USER

MAILDIR=/var/spool/vmail/mailboxes/${DOMAIN}/${USER}/mail
USE_LAST=0

SCRIPT="$(readlink -f "$0")"
BASEDIR="$(readlink -f "$(dirname ${SCRIPT})/..")"

CACHEDIR="${BASEDIR}/cache"

mkdir -p "${CACHEDIR}"

DATE=$(date +"%Y-%m-%d %H:%M:%S")

echo "Collecting latest mail files"

if [ "${USE_LAST}" == "1" ] && [ -f "${CACHEDIR}/.last" ]; then
    LASTDATE=$(cat "${CACHEDIR}/.last")
    find "${MAILDIR}/cur/" -type f -newermt "${LASTDATE}" -exec mv '{}' "${CACHEDIR}/" \;
    find "${MAILDIR}/new/" -type f -newermt "${LASTDATE}" -exec mv '{}' "${CACHEDIR}/" \;
else
    find "${MAILDIR}/cur/" -type f -exec mv '{}' "${CACHEDIR}/" \;
    find "${MAILDIR}/new/" -type f -exec mv '{}' "${CACHEDIR}/" \;
fi

grep -hrie "^Subject:\|^From:" "${CACHEDIR}/"

echo "${DATE}" > ${CACHEDIR}/.last
