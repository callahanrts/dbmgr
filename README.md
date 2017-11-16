# Dbmgr
[![Build Status](https://travis-ci.org/callahanrts/dbmgr.svg?branch=master)](https://travis-ci.org/callahanrts/dbmgr)

`dbmgr` is a command line tool for backing up and restoring databases. It's a useful
tool for:
- Backing up and restoring your development databases
- Sharing databases between developers
- Provisioning new Vagrant VMs and Docker images
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

## Usage
```
dbmgr [dbms] [action] --options-list
```
### DBMSs
- MySQL (mysql)
- PostgreSQL (psql)

### Backup
#### Back up a database
```bash
# Back up database from local server
dbmgr [dbms] backup database_name

# Back up database from a remote server
dbmgr [dbms] backup database_name -P 3307 -h 192.168.33.10 -u root

# Back up database and store in a specific location
dbmgr [dbms] backup database_name -p ~/Downloads

# Back up database as a named backup
dbmgr [dbms] backup database_name -f my_backup.sql
```

### Restore
#### Restore a MySQL database
```bash
# Restore local database from the latest backup in the default location
dbmgr [dbms] restore database_name

# Restore remote database with the latest backup
dbmgr [dbms] restore database_name -P 3307 -h 192.168.33.10 -u root

# Restore local database from the latest backup in a specific location
dbmgr [dbms] restore database_name -p ~/Downloads

# Restore database from a named backup
dbmgr [dbms] restore database_name -f my_backup.sql
```

## Help
```
dbmgr help
dbmgr help mysql
dbmgr mysql help backup
dbmgr psql help backup
...
```

## Tips
Add a function in your `~/.bashrc` to back up a specific database so you don't
have to type out all of the options each time.
```bash
function dbbackup(){
  dbmgr mysql backup mydb_dev -P 3306 -h 192.168.99.100
}

function dbrestore() {
  dbmgr mysql restore mydb_dev -P 3306 -h 192.168.99.100
}
```

## Contributing

### Build the Gem
```bash
gem build dbmgr.gemspec
```

### Install the Built Gem
```bash
gem install ./dbmgr-x.x.x.gem
```
