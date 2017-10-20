
module Dbmgr
  class CLI < Thor

    #
    # Backup
    #
    desc "backup [database_name]", "Create a backup"
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

    method_option :database,
                  aliases: "d",
                  type: :string,
                  default: "mysql",
                  banner: "mysql",
                  desc: "Database type"

    def backup db_name
      Database.new(options)
              .extend(DATABASES[options[:database].to_sym])
              .backup db_name
    end

  end
end
