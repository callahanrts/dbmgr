require 'fileutils'

module PostgreSQL
  def backup(db_name)
    FileUtils::mkdir_p @path

    # Create a postgresql backup from the user supplied options
    system backup_db_command(db_name), out: File::NULL
  rescue
    raise 'Unable to back up database'
  end

  def restore(db_name)
    # Create the database to restore if it doesn't exist already
    system create_db_command(db_name), out: File::NULL

    # Restore the database from a backup
    system restore_db_command(db_name), out: File::NULL
  rescue
    raise 'Unable to restore database'
  end

  private

  def backup_db_command(db_name)
    %( pg_dump -U #{@user} \
               -h #{@host} \
               -p #{@port} #{db_name} > #{filepath db_name})
  end

  def create_db_command(db_name)
    %( PGOPTIONS='--client-min-messages=warning' \
       psql -U postgres \
            -h #{@host} \
            -p #{@port} \
            -c "DROP DATABASE IF EXISTS #{db_name}" \
            -c "CREATE DATABASE #{db_name}")
  end

  def restore_db_command(db_name)
    %( psql -d #{db_name} \
            -U #{@user} \
            -h #{@host} \
            -p #{@port} \
            -f #{backup_file db_name})
  end
end
