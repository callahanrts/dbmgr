require 'yaml'

module Dbmgr::CLI
  class Mysql < Thor

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

    def backup db_name
      file = options[:filename] || "#{db_name}_#{Time.now.to_i}.sql"
      puts "Backing up '#{db_name}' (#{options[:path]}/#{file})..."

      # Create the backups directory if it doesn't exist already
      system "mkdir -p #{options[:path]}"

      # Create a mysql backup from the user supplied options
      system "mysqldump -u#{options[:user]} -h #{options[:host]} -P #{options[:port]} #{db_name} > #{options[:path]}/#{file}"
    end


    #
    # Restore
    #
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
      puts "Create database if it doesn't exist..."

      # Create the database to restore if it doesn't exist already
      system "mysql -u#{options[:user]} -h #{options[:host]} -P #{options[:port]} -e \"CREATE DATABASE IF NOT EXISTS #{db_name}\""

      # Grab the backup file or the latest backup from the backups directory
      backup = options[:backup] || Dir.glob("#{options[:path]}/#{db_name}_*.sql").last
      raise "Restore failed: backup not found" unless File.file?(backup.to_s)

      # Restore the database from a backup
      system("mysql -u#{options[:user]} #{db_name} -h #{options[:host]} -P #{options[:port]} < #{backup}")
    end

  private

    def options
      original = super
      return original unless File.file?("#{home}/.dbmgr")
      config = YAML::load_file("#{home}/.dbmgr") || {dbmgr: {}, mysql: {}}
      config[:dbmgr][:path].gsub!("~/", "#{home}/") if !config[:dbmgr].nil? && config[:dbmgr].has_key?(:path) # Expand ~/ manually
      Thor::CoreExt::HashWithIndifferentAccess.new([config[:dbmgr], config[:mysql], original].reduce &:merge)
    end

    def home
      ENV["HOME"]
    end

  end
end
