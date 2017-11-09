require 'pg'

class PostgreSQLHelper
  PG_DB_NAME = 'postgres'
  DB_NAME = 'dbmgr_test'

  def initialize names
    drop
    create
    insert_users names
  end

  def truncate
    pg_exec DB_NAME, ["TRUNCATE TABLE users"]
  end

  def drop
    pg_exec ["DROP DATABASE IF EXISTS #{DB_NAME}"]
  end

  def num_users
    users = 0
    pg_exec DB_NAME, ["SELECT * FROM users"] do |results|
      users = results.first.values.size
    end
    users
  end

  private

  def create
    pg_exec ["CREATE DATABASE #{DB_NAME}"]
    pg_exec DB_NAME, ["CREATE TABLE users (name varchar(20))"]
  end

  def insert_users names
    commands = names.map{|name| "INSERT INTO users VALUES ('#{name}')"}
    pg_exec DB_NAME, commands
  end

  def pg_exec(db_name = nil, queries, &block)
    client = pg_client(db_name)
    results = queries.map{ |query| client.exec query }
    yield results if block_given?
    client.close
  end

  def pg_client(db_name = nil)
    PG::Connection.new(nil, 5432, nil, nil, db_name, nil, nil)
  end
end
