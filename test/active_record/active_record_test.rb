require 'test_helper'

class ActiveRecord::ConnectionAdapters::VitessClientTest < Minitest::Test
  class UserUuid < ActiveRecord::Base
    shard_key :user_id
  end

  def test_shard_assistant
    assert UserUuid.singleton_class.ancestors.include?(ActiveRecord::VitessShardAssistant), "vitess_shard_assistant should be included by ActiveRecord::Base"
  end

  def test_active_recoord
    user_id = rand(10000000)
    uuid = UserUuid.create(uuid: 'hoge', user_id: user_id)
    refute_equal(0, uuid.id, "id should not be 0 after create.")
    assert_kind_of(Integer, uuid.id, "id should be an integer.")

    uuids_where = UserUuid.where(user_id: user_id)
    refute_equal(0, uuids_where.count, "at least one user_uuid should exist")

    uuid_found = UserUuid.where(user_id: user_id, uuid: uuid.uuid).first
    assert_equal('hoge', uuid_found.uuid, "uuid must be hoge")

    updated_uuid = 'moge'.freeze

    uuid_found.update(uuid: updated_uuid)
    uuid_updated = UserUuid.where(user_id: user_id, uuid: updated_uuid).first
    assert_equal(uuid_updated.id, uuid_found.id, "now uuid should be moge")

    delete_response = UserUuid.destroy_all(user_id: user_id, uuid: uuid_updated)
    assert(delete_response, "destroy response should not be nil")

    updated_uuids = UserUuid.where(user_id: user_id, uuid: uuid_updated)
    assert_equal(0, updated_uuids.count, "deleting shoud works")
  end

  def test_ar_reload
    user_id = rand(10000000)
    uuid = UserUuid.create(uuid: 'fugefuge', user_id: user_id)
    uuid.reload
    assert(uuid.id, "correctly reloaded")
  end
end