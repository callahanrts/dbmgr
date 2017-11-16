require 'dbmgr/postgresql/backup'
require 'dbmgr/postgresql/restore'

module Dbmgr
  class CLI < Thor

    desc "psql", "Run commands on PostgreSQL Databases"
    subcommand "psql", Dbmgr::PostgreSQLCLI

  end
end
