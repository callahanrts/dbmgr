require 'mysql2'

class MySQLHelper
  DB_NAME = "dbmgr_test"

  def initialize names
    initialize_database
    insert_users names
  end

  def truncate
    mysql_client(DB_NAME).query "TRUNCATE TABLE users"
  end

  def drop
    mysql_client(DB_NAME).query "DROP DATABASE IF EXISTS dbmgr_test"
  end

  def num_users
    results = mysql_client(DB_NAME).query("SELECT * from users")
    results.count
  end

  private

  def initialize_database
    client = mysql_client
    client.query("DROP DATABASE IF EXISTS #{DB_NAME}")
    client.query("CREATE DATABASE #{DB_NAME}")
  end

  def insert_users names
    client = mysql_client DB_NAME
    client.query("CREATE TABLE users (name VARCHAR(20))")
    names.each do |name|
      client.query("INSERT INTO users VALUES ('#{name}')")
    end
  end

  def mysql_client(db_name = nil)
    options = { host: "localhost", username: "root" }
    options.merge!(database: db_name) unless db_name.nil?
    Mysql2::Client.new(options)
  end

end
