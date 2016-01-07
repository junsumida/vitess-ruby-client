require 'test_helper'

require 'active_record'

class ActiveRecord::ConnectionAdapters::VitessClientTest < Minitest::Test
  ActiveRecord::Base.configurations = {
      'test' => {
          'adapter' => 'vitess',
          'host'    => '192.168.99.100:15002'
      }
  }

  ActiveRecord::Base.establish_connection(adapter: 'vitess', host: '192.168.99.100:15002')

  class UserModel < ActiveRecord::Base
  end

  def test_active_recoord
    UserModel.new
  end
end