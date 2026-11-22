#!/usr/bin/env bash
#tunneittain  serverin A /var/www/html serverille B
#ajaa serverin B käyttäjänä wwwbackup

set -u

SOURCE="wwwbackup@192.168.1.201:/var/www/html/"
SSH_KEY="/var/lib/wwwbackup/.ssh/backup_ed25519"
BACKUP_DIR="/srv/backups/www"
LOG_FILE="/var/log/wwwbackup.log"
KEEP=48

timestamp=$(date +%Y-%m-%d_%H%M)
target="$BACKUP_DIR/$timestamp"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') $1" >> "$LOG_FILE"
}

if rsync -a -e "ssh -i $SSH_KEY -o BatchMode=yes" "$SOURCE" "$target/"; then
    log "OK     $timestamp"
else
    status=$?
    log "FAILED $timestamp (rsync exit code $status)"
    rm -rf "$target"
    exit 1
fi

#pitää vaan uusimmat $KEEP backupit, poistaa vanhemmat
ls -1d "$BACKUP_DIR"/20* | head -n -"$KEEP" | xargs -r rm -rf
