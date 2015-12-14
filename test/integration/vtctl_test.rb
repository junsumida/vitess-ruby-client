require 'test_helper'

class Vitess::Vtctl::ClientTest < Minitest::Test
  def test_list_all_tablets_in_a_cell
    cell_name    = 'test'
    vtctl_client = Vitess::Vtctl::Client.new(host:'localhost:15999')
    result       = vtctl_client.list_all_tablets(cell_name)
    assert result
    refute_equal result.to_a.count, 0, "the tablet count in '#{cell_name}' cell should not be 0."
  end
end