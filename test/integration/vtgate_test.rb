require 'test_helper'

class Vitess::ClientIntegrationTest < Minitest::Test
  FOOBAR_INSERT = 'insert into test_table(msg) values("foobar")'

  def test_basic_selects_and_inserts
    insert_sql = 'insert into test_table(msg) values("mogemoge")'
    vtgate     = Vitess::Client.new(host:'192.168.99.100:15002')

    initial_resp = vtgate.query_with_keyspace_ids('SELECT * FROM test_table', keyspace: 'test_keyspace')
    initial_row_count = initial_resp.result.rows.count
    assert_kind_of Fixnum, initial_row_count, 'row count should be a fixnum'

    vtgate.connect
    insert_resp = vtgate.query_with_keyspace_ids(insert_sql, keyspace: 'test_keyspace')
    assert insert_resp
    vtgate.commit
    select_resp = vtgate.query_with_keyspace_ids('SELECT * FROM test_table', keyspace: 'test_keyspace')
    assert_kind_of Fixnum, select_resp.result.rows.count, 'rows count should be a fixnum'
    assert_equal initial_row_count, select_resp.result.rows.count - 1, 'one row should be inserted'
  end

  def test_rollback
    insert_sql = 'insert into test_table(msg) values("hogehoge")'
    vtgate     = Vitess::Client.new(host: '192.168.99.100:15002')

    vtgate.connect
    insert_resp = vtgate.query_with_keyspace_ids(insert_sql, keyspace: 'test_keyspace')
    assert insert_resp

    vtgate.rollback
    select_resp = vtgate.query_with_keyspace_ids('select * from test_table where msg = "hogehoge"', keyspace: 'test_keyspace')
    assert_equal select_resp.result.rows.count, 0, 'inserting "hogehoge" must be roll-backed.'

    # the current session is not in a transaction
    assert_raises(GRPC::BadStatus) { vtgate.commit }
  end

  def test_delete_queries
    vtgate = Vitess::Client.new(host:'192.168.99.100:15002')
    vtgate.connect
    insert_resp = vtgate.query_with_keyspace_ids(FOOBAR_INSERT, keyspace: 'test_keyspace')
    assert insert_resp

    # checking if inserted records exist
    select_resp = vtgate.query_with_keyspace_ids('select * from test_table where msg = "foobar"', keyspace: 'test_keyspace')
    assert_equal select_resp.result.rows.count, 1, 'A row with foobar msg should exist in the test_table'

    delete_resp = vtgate.query_with_keyspace_ids('delete from test_table where msg = "foobar"', keyspace: 'test_keyspace')
    assert_equal delete_resp.result.rows_affected, 1, 'One row should be deleted from test_table'

    reselect_resp = vtgate.query_with_keyspace_ids('select * from test_table where msg = "foobar"', keyspace: 'test_keyspace')
    assert_equal reselect_resp.result.rows.count, 0, 'No rows with foobar msg should exist'
  end
end