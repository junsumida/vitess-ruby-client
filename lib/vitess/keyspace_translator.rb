require 'digest/md5'

module Vitess
  class KeyspaceTranslator
    attr_reader :strategy

    def initialize(sharding_type: sharding_type)
      case sharding_type
        when :consistent_hashing
          @strategy = ConsistentHash.new
        when :id
          @strategy = ID.new
        else
          fail
      end
    end

    def translate(id=nil)
      @strategy.translate(id).to_s
    end

    class ConsistentHash
      def translate(id)
        Digest::MD5.hexdigest(id.to_s).hex
      end
    end

    class ID
      def translate(id)
        id
      end
    end

    class NoSuchKeyspaceTranslatorError < StandardError; end
  end
end