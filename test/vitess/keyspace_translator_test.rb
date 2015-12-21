require 'test_helper'

class Vitess::KeyspaceTranslatorTest < Minitest::Test
  def test_initialization
    translator = Vitess::KeyspaceTranslator.new(sharding_type: :id)
    assert_equal Vitess::KeyspaceTranslator::ID, translator.strategy.class, 'the class of keyspace_translator is ID'

    translator = Vitess::KeyspaceTranslator.new(sharding_type: :consistent_hashing)
    assert_equal Vitess::KeyspaceTranslator::ConsistentHash, translator.strategy.class, 'the class of keyspace_translator is ConsistentHash'
  end
end