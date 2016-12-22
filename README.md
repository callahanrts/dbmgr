# Dbmgr

`dbmgr` is a command line tool for backing up and restoring development databases. I created this
because my inexperience led me to run `docker-compose down` on our MySQL image causing me to
_unexpectedly_ lose my development database. Since that day, I've found `dbmgr` to be very useful
in:
- Sharing databases between developers on our team
- Provisioning new developers with a working database

## Installation

```
$ gem install dbmgr
```

## Usage

#### Backup
##### Help
```
dbmgr mysql help backup
```
```
dbmgr mysql backup --options
```

#### Restore
```
dbmgr mysql restore --options
```
