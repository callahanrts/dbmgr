require 'test_helper'

describe Dbmgr::CLI do

  Dbmgr::DATABASES.keys.each do |database|
    describe "when restoring a #{database} database" do
      before do
        @db = database_helper database
        @users = @db.num_users
        `mkdir -p #{HOME}` # Create test home directory
      end

      after do
        `rm -rf #{HOME}`
      end

      it 'should restore from the latest backup in the default path' do
        Dbmgr::CLI.start([database, "backup", "dbmgr_test"])
        @db.truncate
        Dbmgr::CLI.start([database, "restore", "dbmgr_test"])
        @db.num_users.must_equal @users
      end

      it 'should restore from the latest backup when the database does not exist' do
        Dbmgr::CLI.start([database, "backup", "dbmgr_test"])
        @db.drop
        Dbmgr::CLI.start([database, "restore", "dbmgr_test"])
        @db.num_users.must_equal @users
      end

      it 'should throw an error if no backup is found' do
        assert_raises RuntimeError do
          Dbmgr::CLI.start([database, "restore", "dbmgr_test"])
        end
      end

      describe 'using a named backup' do
        before do
          Dbmgr::CLI.start([database, "backup", "dbmgr_test", "-f", "my_backup.sql"])
        end

        it 'should restore from a specified backup' do
          @db.drop
          Dbmgr::CLI.start([database, "restore", "dbmgr_test", "-b", "#{HOME}/.db_backups/my_backup.sql"])
          @db.num_users.must_equal @users
        end

      end

    end

  end

end

