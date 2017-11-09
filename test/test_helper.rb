$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

HOME = '/tmp/dbmgr'
ENV["HOME"] = HOME
BACKUPS = "#{HOME}/.db_backups"
NAMES = ["fred", "joe", "bob", "sue", "jane"]
DATABASES = [:mysql, :psql]

require 'dbmgr'
require 'minitest/autorun'
require 'mocha/mini_test'
require 'helpers/mysql_helper'
require 'helpers/postgresql_helper'

def database_helper(database)
  case database.to_sym
  when :mysql then MySQLHelper.new NAMES
  when :psql then PostgreSQLHelper.new NAMES
  end
end
