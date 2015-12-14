require 'test_helper'

class Vitess::ClientIntegrationTest < Minitest::Test
  def test_basic_selects_and_inserts
    insert_sql = 'insert into test_table(msg) values("mogemoge")'

    initial_resp = Vitess::Client.query_with_keyspace_ids('SELECT * FROM test_table', keyspace: 'test_keyspace')
    initial_row_count = initial_resp.result.rows.count
    assert_kind_of Fixnum, initial_row_count, 'row count should be a fixnum'

    transaction = Vitess::Client.connect
    assert transaction.session
    insert_resp = Vitess::Client.query_with_keyspace_ids(insert_sql, keyspace: 'test_keyspace', session: transaction.session)
    assert insert_resp.session
    commit      = Vitess::Client.commit(session: insert_resp.session)
    select_resp = Vitess::Client.query_with_keyspace_ids('SELECT * FROM test_table', keyspace: 'test_keyspace')
    assert_kind_of Fixnum, select_resp.result.rows.count, 'rows count should be a fixnum'
    assert_equal initial_row_count, select_resp.result.rows.count - 1, 'one row should be inserted'
  end
end