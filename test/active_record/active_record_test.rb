require 'test_helper'

require 'active_record'

class ActiveRecord::ConnectionAdapters::VitessClientTest < Minitest::Test
  ActiveRecord::Base.configurations = {}
  config = {
      adapter: 'mysql2',
      host: 'localhost',
      database: 'test',
      vtgate_config: { host: '192.168.99.100:15002' },
  }

  class CreateUsers < ActiveRecord::Migration
  end

  ActiveRecord::Base.establish_connection(config)

  class User < ActiveRecord::Base
  end

  def test_active_recoord
    User.new
  end
end