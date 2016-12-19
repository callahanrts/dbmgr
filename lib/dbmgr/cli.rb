require 'thor'
require 'dbmgr/cli/mysql'

module Dbmgr
  class DbMgr < Thor

    desc "mysql [COMMAND]", "Run commands on MySQL Databases"
    subcommand "mysql", Dbmgr::CLI::Mysql

  end
end
