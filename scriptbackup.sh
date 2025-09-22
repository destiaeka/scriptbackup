#!/bin/bash

# database credentials
DB_NAME="curd-1"
DB_USER="destiaeka"
DB_PASS="112233"
BACKUP_DIR="/var/backup/mysql"
DATE=$(date +%F)
TIMESTAMP=$(date +%F_%H-%M)      

# website credentials
SOURCE_DIR="/var/www/simple-crud-php"
BACK_DIR="/var/backup/website"

# make backup directory
mkdir -p "$BACKUP_DIR"
mkdir -p "$BACK_DIR"

# backup mysql database
mysqldump -u"$DB_USER" -p"$DB_PASS" "$DB_NAME" > "$BACKUP_DIR/backup_$DATE.sql"

# backup website
tar -czf "$BACK_DIR/backup_$DATE.tar.gz" "$SOURCE_DIR"

# hapus backup database lebih dari 5
cd "$BACKUP_DIR"
ls -tp backup_*.sql | grep -v '/$' | tail -n +6 | xargs -r rm --

# hapus backup web lebih dari 5
cd "$BACK_DIR"
ls -tp backup_*.tar.gz | grep -v '/$' | tail -n +6 | xargs -r rm --
