require 'dbmgr/mysql/backup'
require 'dbmgr/mysql/restore'

module Dbmgr
  class CLI < Thor

    desc "mysql", "Run commands on MySQL Databases"
    subcommand "mysql", Dbmgr::MySQLCLI

  end
end
