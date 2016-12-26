# Dbmgr

`dbmgr` is a command line tool for backing up and restoring databases. It's a useful
tool for:
- Sharing databases between developers
- Provisioning new Vagrant vms and Docker images
- Provisioning new developers with a working database

## Installation

```
$ brew install callahanrts/dbmgr/dbmgr
```
or
```
$ gem install dbmgr
```

## Usage

#### Help
```
$ dbmgr help
```

#### Backup
```
$ dmgr mysql backup --options
```

#### Restore
```
$ dbmgr mysql restore --options
```

#### Config
Options can either be passed in each command or they can be set as defaults in the `~/.dbmgr`
config file.
```ruby
# ~/.dbmgr

:dbmgr:
  :path: "~/.db_backups"

:mysql:
  :port: 3306
  :host: 'localhost'
  :user: "root"
```

## Examples
#### Back up a MySQL database

```bash
# Back up database from local MySQL server
$ dbmgr mysql backup database_name

# Back up database from a remote MySQL server
$ dbmgr mysql backup database_name -P 3307 -h 192.168.33.10 -u root

# Back up database and store in a specific location
$ dbmgr mysql backup database_name -p ~/Downloads

# Back up database as a named backup
$ dbmgr mysql backup database_name -f my_backup.sql
```

#### Restore a MySQL database
```bash
# Restore local database from the latest backup in the default location
$ dbmgr mysql restore database_name

# Restore remote database with the latest backup
$ dbmgr mysql restore database_name -P 3307 -h 192.168.33.10 -u root

# Restore local database from the latest backup in a specific location
$ dbmgr mysql restore database_name -p ~/Downloads

# Restore database from a named backup
$ dbmgr mysql restore database_name -f my_backup.sql
```
