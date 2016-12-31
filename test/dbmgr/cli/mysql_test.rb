require 'test_helper'
require 'mysql2'

describe Dbmgr::CLI::Mysql do
  DEBUG = false # true will enable stdout

  original_stderr = $stderr
  original_stdout = $stdout

  before do
    unless DEBUG
      # Redirect stderr and stdout
      $stderr = File.open(File::NULL, "w")
      $stdout = File.open(File::NULL, "w")
    end
  end

  after do
    unless DEBUG
      $stderr = original_stderr
      $stdout = original_stdout
    end
  end

  describe 'Mysql' do
    HOME = '/tmp/dbmgr'

    def mysql_client
      Mysql2::Client.new(:host => "localhost", :username => "root", :database => "dbmgr_test")
    end

    def num_users
      results = mysql_client.query("SELECT * from users")
      results.count
    end

    def default_options
      {
        path: "#{HOME}/db_backups",
        port: 3306,
        host: 'localhost',
        user: "root"
      }
    end

    before do
      init_mysql_database
      `mkdir -p #{HOME}` # Create test home directory
      Thor.any_instance.stubs(:options).returns default_options
      Dbmgr::CLI::Mysql.any_instance.stubs(:home).returns "/tmp/dbmgr"

      @dbmgr = Dbmgr::CLI::Mysql.new
    end

    after do
      `rm -rf #{HOME}`
    end

    it 'should provision the database for testing' do
      num_users.must_equal 5
    end

    describe 'when backing up a database' do
      it 'should create a backup directory' do
        @dbmgr.backup "dbmgr_test"
        File.directory?(default_options[:path])
      end

      it 'should create a backup' do
        @dbmgr.backup "dbmgr_test"
        Dir.glob("#{default_options[:path]}/*.sql").length.must_equal 1
      end

      it 'should, by default, create a backup named: [database]_[timestamp]' do
        @dbmgr.backup "dbmgr_test"
        backup = Dir.glob("#{default_options[:path]}/*.sql").first
        (backup =~ /dbmgr_test_\d*.sql/).nil?.must_equal false
      end

      it 'should create a backup with a given filename' do
        Thor.any_instance.stubs(:options).returns default_options.merge(filename: "my_backup.sql")
        @dbmgr.backup "dbmgr_test"
        File.file?("#{default_options[:path]}/my_backup.sql").must_equal true
      end
    end

    describe 'when restoring a database' do
      def client
        Mysql2::Client.new(:host => "localhost", :username => "root", :database => "dbmgr_test")
      end

      def prepare_and_restore destructive_query
        @dbmgr.backup "dbmgr_test"
        client.query destructive_query
        @dbmgr.restore "dbmgr_test"
      end

      before do
        @users = client.query("SELECT * FROM users").count
      end

      it 'should restore from the latest backup in the default path' do
        prepare_and_restore "TRUNCATE TABLE users"
        client.query("SELECT * FROM users").count.must_equal @users
      end

      it 'should restore from the latest backup when the database does not exist' do
        prepare_and_restore "DROP DATABASE IF EXISTS dbmgr_test"
        client.query("SELECT * FROM users").count.must_equal @users
      end

      it 'should throw an error if no backup is found' do
        assert_raises RuntimeError do
          @dbmgr.restore "dbmgr_test"
        end
      end

      describe 'using a named backup' do
        before do
          Thor.any_instance.stubs(:options).returns default_options.merge({
            filename: "my_backup.sql",
            backup: "#{default_options[:path]}/my_backup.sql"
          })
        end

        it 'should restore from a specified backup' do
          prepare_and_restore "DROP DATABASE IF EXISTS dbmgr_test"
          client.query("SELECT * FROM users").count.must_equal @users
        end

      end
    end

  end

end
