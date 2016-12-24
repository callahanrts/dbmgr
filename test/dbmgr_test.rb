require 'test_helper'
require 'mysql2'

describe Dbmgr do

  describe 'Mysql' do

    def mysql_client
      Mysql2::Client.new(:host => "localhost", :username => "root", :database => "dbmgr_test")
    end

    def num_users
      results = mysql_client.query("SELECT * from users")
      results.count
    end

    before do
    end

    afterEach do
    end

    it 'should provision the database for testing' do
      num_users.must_equal 5
    end

    describe 'when backing up a database' do
      it 'should create a directory for the default path' do
      end

      it 'should create a backup in the default path' do
      end

      it 'should create a directory for a specified path' do
      end

      it 'should create a backup in the specified path' do
      end

      it 'should, by default, create a backup named: [database]_[timestamp]' do
      end

      it 'should create a backup with a given filename' do
      end
    end

    describe 'when restoring a database' do
      it 'should restore from the latest backup in the default path' do
      end

      it 'should restore from the latest backup in a specified path' do
      end

      it 'should restore from a specified backup' do
      end
    end

  end

end
