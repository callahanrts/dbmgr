# Dbmgr

`dbmgr` is a command line tool for backing up and restoring databases. It's a useful
tool for:
- Sharing databases between developers
- Provisioning new Vagrant vms and Docker images
- Provisioning new developers with a working database

## Installation

```
$ brew tap callahanrts/dbmgr
$ brew install dbmgr
```
or
```
$ gem install dbmgr
```

## Backup
### Back up a MySQL database
```bash
# Back up database from local MySQL server
$ dbmgr backup database_name -d mysql

# Back up database from a remote MySQL server
$ dbmgr backup database_name -d mysql -P 3307 -h 192.168.33.10 -u root

# Back up database and store in a specific location
$ dbmgr backup database_name -d mysql -p ~/Downloads

# Back up database as a named backup
$ dbmgr backup database_name -d mysql -f my_backup.sql
```

## Restore
### Restore a MySQL database
```bash
# Restore local database from the latest backup in the default location
$ dbmgr restore database_name -d mysql

# Restore remote database with the latest backup
$ dbmgr restore database_name -d mysql -P 3307 -h 192.168.33.10 -u root

# Restore local database from the latest backup in a specific location
$ dbmgr restore database_name -d mysql -p ~/Downloads

# Restore database from a named backup
$ dbmgr restore database_name -d mysql -f my_backup.sql
```
