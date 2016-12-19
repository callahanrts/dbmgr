module Dbmgr::CLI
  class MySQL < Thor

    #
    # Backup
    #
    desc "backup [database_name]", "Create a backup"
    method_option :filename, aliases: ["f"], type: :string, banner: "my_backup.sql", desc: "Name of the backup created"
    method_option :path, aliases: ["p"], type: :string, default: "#{ENV["HOME"]}/.db_backups", banner: "#{ENV["HOME"]}/.db_backups", desc: "Directory of database backups"
    method_option :dbport, aliases: ["P"], type: :numeric, default: 3306, banner: "3306", desc: "MySQL database port"
    method_option :dbhost, aliases: ["h"], type: :string, default: "localhost", banner: "localhost", desc: "MySQL database host"
    method_option :dbuser, aliases: ["u"], type: :string, default: "root", banner: "root", desc: "MySQL database user"

    def backup db_name
      puts "Backing up #{db_name}..."
      file = options[:filename] || "#{db_name}_#{Time.now.to_i}.sql"

      # Create the backups directory if it doesn't exist already
      system "mkdir -p #{options[:path]}"

      # Create a mysql backup from the user supplied options
      system "mysqldump -u#{options[:dbuser]} -h #{options[:dbhost]} -P #{options[:dbport]} #{db_name} > #{options[:path]}/#{file}"
    end


    #
    # Restore
    #
    desc "restore", "Restore from a backup"
    method_option :backup, aliases: ["b"], type: :string, banner: "#{ENV["HOME"]}/.db_backups/backup.sql", desc: "Path to backup to restore from"
    method_option :path, aliases: ["p"], type: :string, default: "#{ENV["HOME"]}/.db_backups", banner: "#{ENV["HOME"]}/.db_backups", desc: "Directory of database backups"
    method_option :dbport, aliases: ["P"], type: :numeric, default: 3306, banner: "3306", desc: "MySQL database port"
    method_option :dbhost, aliases: ["h"], type: :string, default: "localhost", banner: "localhost", desc: "MySQL database host"
    method_option :dbuser, aliases: ["u"], type: :string, default: "root", banner: "root", desc: "MySQL database user"

    def restore db_name
      puts "Create database if it doesn't exist..."

      # Create the database to restore if it doesn't exist already
      system "mysql -u#{options[:dbuser]} -h #{options[:dbhost]} -P #{options[:dbport]} -e \"CREATE DATABASE IF NOT EXISTS #{db_name}\""

      # Grab the backup file or the latest backup from the backups directory
      backup = options[:backup] || Dir.glob("#{options[:path]}/#{db_name}_*.sql").last
      raise "Restore failed: backup not found" unless File.file?(backup)

      # Restore the database from a backup
      system("mysql -u#{options[:dbuser]} #{db_name} -h #{options[:dbhost]} -P #{options[:dbport]} < #{backup}")
    end

  end
end


