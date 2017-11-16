module Dbmgr
  class PostgreSQLCLI < Thor

    desc "backup", "Create a backup"
    method_option :filename,
                  aliases: ["f"],
                  type: :string,
                  banner: "my_backup.sql",
                  desc: "Name of the backup created"

    method_option :path,
                  aliases: ["p"],
                  type: :string,
                  default: "#{ENV["HOME"]}/.db_backups",
                  banner: "#{ENV["HOME"]}/.db_backups",
                  desc: "Directory of database backups"

    method_option :port,
                  aliases: ["P"],
                  type: :numeric,
                  default: 5432,
                  banner: "5432",
                  desc: "PostgreSQL database port"

    method_option :host,
                  aliases: ["h"],
                  type: :string,
                  default: "localhost",
                  banner: "localhost",
                  desc: "PostgreSQL database host"

    method_option :user,
                  aliases: ["u"],
                  type: :string,
                  default: 'postgres',
                  banner: "postgres",
                  desc: "PostgreSQL database user"

    def backup db_name
      Database.new(options)
              .extend(PostgreSQL)
              .backup db_name
    end

  end
end
