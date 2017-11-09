require "database/mysql"
require "database/postgresql"

# Database Class
class Database
  def initialize(options = {})
    @user = options[:user]
    @host = options[:host]
    @port = options[:port]
    @path = options[:path]
    @file = options[:filename]
    @backup = options[:backup]
  end

  private

  # Construct a name for the backup. This is either a given name or a timestamped name
  # for the given database name
  def filename db_name
    @file || "#{db_name}_#{Time.now.to_i}.sql"
  end

  # Back up from a given backup file--default to the most recent timestamped backup
  def backup_file db_name
    # Grab the backup file or the latest backup from the backups directory
    backup = @backup || Dir.glob("#{@path}/#{db_name}_*.sql").last
    raise "Restore failed: backup not found" unless File.file?(backup.to_s)
    backup
  end

  # Construct the /file/path/backup.sql string
  def filepath db_name
    "#{@path}/#{filename db_name}"
  end

end
