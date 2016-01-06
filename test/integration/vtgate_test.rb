require 'test_helper'

class Vitess::ClientIntegrationTest < Minitest::Test
  def insert_sql(value)
   'insert into test_table(msg) values("' + value + '")'
  end

  def select_sql(value)
    'select * from test_table where msg = "' + value +'"'
  end

  def setup
    vtgate = Vitess::Client.new(host:'192.168.99.100:15002')
    vtgate.cursor(keyspace: 'test_keyspace', keyspace_ids: [0])
    vtgate.begin
    vtgate.query_with_keyspace_ids('delete from test_table')
    vtgate.commit
  end

  def test_basic_selects_and_inserts
    insert_sql = 'insert into test_table(msg) values("mogemoge")'
    vtgate     = Vitess::Client.new(host:'192.168.99.100:15002', default_sharding_type: :id)
    vtgate.cursor(keyspace: 'test_keyspace', keyspace_ids: [0])

    initial_resp = vtgate.query_with_keyspace_ids('SELECT * FROM test_table')
    initial_row_count = initial_resp.result.rows.count
    assert_kind_of Fixnum, initial_row_count, 'row count should be a fixnum'

    vtgate.begin
    insert_resp = vtgate.query_with_keyspace_ids(insert_sql)
    assert insert_resp
    vtgate.commit

    select_resp = vtgate.query_with_keyspace_ids('SELECT * FROM test_table')
    assert_kind_of Fixnum, select_resp.result.rows.count, 'rows count should be a fixnum'
    assert_equal initial_row_count, select_resp.result.rows.count - 1, 'one row should be inserted'
  end

  def test_rollback
    vtgate     = Vitess::Client.new(host:'192.168.99.100:15002', default_sharding_type: :id)
    vtgate.cursor(keyspace: 'test_keyspace', keyspace_ids: [0])

    vtgate.begin
    insert_resp = vtgate.query_with_keyspace_ids(insert_sql('hogehoge'))
    assert insert_resp

    vtgate.rollback
    select_resp = vtgate.query_with_keyspace_ids(select_sql('hogehoge'))
    assert_equal select_resp.result.rows.count, 0, 'inserting "hogehoge" must be roll-backed.'

    # the current session is not in a transaction
    assert_raises(GRPC::BadStatus) { vtgate.commit }
  end

  def test_delete_queries
    vtgate = Vitess::Client.new(host:'192.168.99.100:15002', default_sharding_type: :id)
    vtgate.cursor(keyspace: 'test_keyspace', keyspace_ids: [0])

    vtgate.begin
    insert_resp = vtgate.query_with_keyspace_ids(insert_sql('foobar'))
    assert insert_resp
    vtgate.commit

    # checking if inserted records exist
    select_resp = vtgate.query_with_keyspace_ids(select_sql('foobar'))
    assert_equal 1, select_resp.result.rows.count, 'A row with foobar msg should exist in the test_table'

    vtgate.begin
    delete_resp = vtgate.query_with_keyspace_ids('delete from test_table where msg = "foobar"')
    assert_equal 1, delete_resp.result.rows_affected, 'One row should be deleted from test_table'
    vtgate.commit

    reselect_resp = vtgate.query_with_keyspace_ids(select_sql('foobar'))
    assert_equal 0, reselect_resp.result.rows.count, 'No rows with foobar msg should exist'
  end

  def test_update_queries
    vtgate = Vitess::Client.new(host:'192.168.99.100:15002', default_sharding_type: :id)
    msg    = 'foobarboo'
    vtgate.cursor(keyspace: 'test_keyspace', keyspace_ids: [0])

    vtgate.begin
    insert_resp = vtgate.query_with_keyspace_ids(insert_sql(msg))
    assert_equal insert_resp.result.rows_affected, 1, 'One row should be inserted.'
    vtgate.commit

     # checking if inserted records exist
    select_resp = vtgate.query_with_keyspace_ids(select_sql(msg))
    assert_equal 1, select_resp.result.rows.count, "A row with #{msg} msg should exist in the test_table"

    vtgate.begin
    update_resp = vtgate.query_with_keyspace_ids('update test_table set msg = "sticky_toffee"')
    assert_equal 1, update_resp.result.rows_affected, "A msg #{msg} should be replaced with sticky_toffee"
    vtgate.commit

    select_resp = vtgate.query_with_keyspace_ids(select_sql('sticky_toffee'))
    assert_equal 1, select_resp.result.rows.count, 'A row with sticky_toffee msg should exist in the test_table'
  end

  def test_vtgate_v3
    vtgate = Vitess::Client.new(host:'192.168.99.100:15002', default_sharding_type: :id)
    result_1 = vtgate.query("select * from user_uuids")
    assert_equal 0, result_1.result.rows.count
    result_1 = vtgate.query("select * from user_uuids where user_id = 1")
    assert_equal 0, result_1.result.rows.count
  end
end