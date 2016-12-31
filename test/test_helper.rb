$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'dbmgr'
require 'mysql2'

require 'minitest/autorun'
require 'mocha/mini_test'

def init_mysql_database
  client = Mysql2::Client.new(:host => "localhost", :username => "root")
  client.query("DROP DATABASE IF EXISTS dbmgr_test")
  client.query("CREATE DATABASE dbmgr_test")

  client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "dbmgr_test")
  client.query("CREATE TABLE users (name VARCHAR(20))")
  client.query("INSERT INTO users VALUES ('fred')")
  client.query("INSERT INTO users VALUES ('joe')")
  client.query("INSERT INTO users VALUES ('bob')")
  client.query("INSERT INTO users VALUES ('sue')")
  client.query("INSERT INTO users VALUES ('jane')")
end
