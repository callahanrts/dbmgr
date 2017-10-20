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

    describe "when restoring a #{database} database" do

      before do
        @users = @db.num_users
      end


      it 'should restore from the latest backup in the default path' do
        Dbmgr::CLI.start(["backup", "dbmgr_test", "-d", database])
        @db.truncate
        Dbmgr::CLI.start(["restore", "dbmgr_test", "-d", database])
        @db.num_users.must_equal @users
      end

      it 'should restore from the latest backup when the database does not exist' do
        Dbmgr::CLI.start(["backup", "dbmgr_test", "-d", database])
        @db.drop
        Dbmgr::CLI.start(["restore", "dbmgr_test", "-d", database])
        @db.num_users.must_equal @users
      end

      it 'should throw an error if no backup is found' do
        assert_raises RuntimeError do
          Dbmgr::CLI.start(["restore", "dbmgr_test", "-d", database])
        end
      end

      describe 'using a named backup' do
        before do
          Dbmgr::CLI.start(["backup", "dbmgr_test", "-f", "my_backup.sql", "-d", database])
        end

        it 'should restore from a specified backup' do
          @db.drop
          Dbmgr::CLI.start(["restore", "dbmgr_test", "-b", "#{HOME}/.db_backups/my_backup.sql", "-d", database])
          @db.num_users.must_equal @users
        end

      end

    end

  end

end

