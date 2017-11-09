require 'fileutils'

module MySQL
  def backup(db_name)
    FileUtils::mkdir_p @path

    # Create a mysql backup from the user supplied options
    system backup_db_command db_name
  rescue
    raise 'Unable to back up database'
  end

  def restore(db_name)
    # Create the database to restore if it doesn't exist already
    system create_db_command db_name

    # Restore the database from a backup
    system restore_db_command db_name
  rescue
    raise 'Unable to restore database'
  end

  private

  def backup_db_command(db_name)
    %( mysqldump -u#{@user} \
                 -h #{@host} \
                 -P #{@port} #{db_name} > #{filepath db_name} )
  end

  def create_db_command(db_name)
    %( mysql -u#{@user} \
             -h #{@host} \
             -P #{@port} \
             -e \"CREATE DATABASE IF NOT EXISTS #{db_name}\" )
  end

  def restore_db_command(db_name)
    %( mysql -u#{@user} #{db_name} \
             -h #{@host} \
             -P #{@port} < #{backup_file db_name})
  end
end
