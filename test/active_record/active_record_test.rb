require 'test_helper'

require 'active_record'

class ActiveRecord::ConnectionAdapters::VitessClientTest < Minitest::Test
  ActiveRecord::Base.configurations = {}
  config = {
      adapter: 'vitess',
      host: 'localhost',
      database: 'test',
      vtgate_config: { host: '192.168.99.100:15002' },
  }

  class CreateUsers < ActiveRecord::Migration
  end

  ActiveRecord::Base.establish_connection(config)

  class UserUuid < ActiveRecord::Base
  end

  def test_active_recoord
    user_id = rand(10000000)
    uuid = UserUuid.create(uuid: 'hoge', user_id: user_id)
    refute_equal(0, uuid.id, "id should not be 0 after create.")
    assert_kind_of(Integer, uuid.id, "id should be an integer.")

    uuids_where = UserUuid.where(user_id: user_id)
    refute_equal(0, uuids_where.count, "at least one user_uuid should exist")

    uuid_found = UserUuid.where(user_id: user_id, id: uuid).first
    assert_equal('hoge', uuid_found.uuid, "uuid must be hoge")
  end
end