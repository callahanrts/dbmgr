require 'dbmgr/mysql/backup'
require 'dbmgr/mysql/restore'

module Dbmgr
  class CLI < Thor

    desc "mysql [COMMAND]", "Run commands on MySQL Databases"
    subcommand "mysql", Dbmgr::MySQLCLI

  end
end
