# Linux Admin Week 4: Server Cloning, Backups and Database Replication

Server B is a clone of server A (cPouta snapshot). B pulls hourly backups of
A's website files and keeps a read-only MariaDB replica of A's database.

- Server A (primary): http://195.148.22.86/viikko2/ - increments the visitor counter
- Server B (replica): http://193.166.25.53/viikko4/ - shows the replicated counter (read-only)

## Files

| File | Purpose |
|---|---|
| `backup-www.sh` | Hourly backup script, runs on B as user `wwwbackup` (installed to `/usr/local/bin/`) |
| `app.py`, `templates/index.html` | Week 4 Flask app on B, reads the counter with `SELECT` only |
| `static/` | Screenshots of the tests |
| `config/crontab-wwwbackup.txt` | Cron schedule for the backup (every hour) |
| `config/primary-60-replication.cnf` | MariaDB replication settings on A |
| `config/replica-60-replication.cnf` | MariaDB replication settings on B (`read_only = ON`) |
| `config/replica-change-master.sql` | Replication start command, password replaced with a placeholder |
| `config/viikko4.service` | systemd service for the week 4 app |
| `config/nginx-viikko4.conf` | Nginx reverse proxy for `/viikko4/` |

## Secrets

No passwords, private keys, database dumps or backup archives are stored in this repository.
The app reads its database credentials from `/etc/viikko4.env` (root, 600) via systemd.
