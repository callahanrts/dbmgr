
module Dbmgr
  class MySQLCLI < Thor

    desc "restore", "Restore from a backup"
    method_option :backup,
                  aliases: ["b"],
                  type: :string,
                  banner: "#{ENV["HOME"]}/.db_backups/backup.sql",
                  desc: "Path to backup to restore from"

    method_option :path,
                  aliases: ["p"],
                  type: :string,
                  default: "#{ENV["HOME"]}/.db_backups",
                  banner: "#{ENV["HOME"]}/.db_backups",
                  desc: "Directory of database backups"

    method_option :port,
                  aliases: ["P"],
                  type: :numeric,
                  default: 3306,
                  banner: "3306",
                  desc: "MySQL database port"

    method_option :host,
                  aliases: ["h"],
                  type: :string,
                  default: "localhost",
                  banner: "localhost",
                  desc: "MySQL database host"

    method_option :user,
                  aliases: ["u"],
                  type: :string,
                  default: "root",
                  banner: "root",
                  desc: "MySQL database user"

    def restore db_name
      Database.new(options)
              .extend(MySQL)
              .restore db_name
    end

  end
end

