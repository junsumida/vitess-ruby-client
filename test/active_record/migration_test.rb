require 'test_helper'

class ActiveRecord::Migration::VitessTest < Minitest::Test
  def setup
    ActiveRecord::Migrator.migrate(['test/migrate'], 0)
  end

  def test_migration
    ActiveRecord::Migrator.migrate(['test/migrate'])
  end
end