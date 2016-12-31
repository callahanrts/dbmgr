require 'test_helper'
require "dbmgr"

describe Dbmgr do

  describe "VERSION" do
    it 'should be a semantic version' do
      (Dbmgr::VERSION =~ /\d*\.\d*\.\d*/).wont_be_nil
    end
  end

end
