require 'test_helper'

class Vitess::ClientIntegrationTest < Minitest::Test
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
end