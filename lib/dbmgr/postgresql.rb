require 'dbmgr/postgresql/backup'
require 'dbmgr/postgresql/restore'

module Dbmgr
  class CLI < Thor

    desc "psql [COMMAND]", "Run commands on MySQL Databases"
    subcommand "psql", Dbmgr::PostgreSQLCLI

  end
end
