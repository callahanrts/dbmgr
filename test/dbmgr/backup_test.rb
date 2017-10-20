require 'test_helper'

describe Dbmgr::CLI do

  Dbmgr::DATABASES.keys.each do |database|

    before do
      @db = database_helper database
      `mkdir -p #{HOME}` # Create test home directory
    end

    after do
      `rm -rf #{HOME}`
    end

    it 'should provision the database for testing' do
      @db.num_users.must_equal NAMES.size
    end

    describe 'when backing up a database' do
      it 'should create a backup directory' do
        Dbmgr::CLI.start(["backup", "dbmgr_test", "-d", database])
        File.directory?(BACKUPS)
      end

      it 'should create a backup' do
        Dbmgr::CLI.start(["backup", "dbmgr_test", "-d", database])
        Dir.glob("#{BACKUPS}/*.sql").length.must_equal 1
      end

      it 'should, by default, create a backup named: [database]_[timestamp]' do
        Dbmgr::CLI.start(["backup", "dbmgr_test", "-d", database])
        backup = Dir.glob("#{BACKUPS}/*.sql").first
        (backup =~ /dbmgr_test_\d*.sql/).nil?.must_equal false
      end

      it 'should create a backup with a given filename' do
        Dbmgr::CLI.start(["backup", "dbmgr_test", "-f", "my_backup.sql", "-d", database])
        File.file?("#{BACKUPS}/my_backup.sql").must_equal true
      end
    end

  end

end

