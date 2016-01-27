$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'vitess/client'

require 'minitest/autorun'

require 'logger'
# RubyLogger defines a logger for gRPC based on the standard ruby logger.
module RubyLogger
  def logger
    LOGGER
  end

  LOGGER = Logger.new(STDOUT)
  LOGGER.level = Logger::INFO
end

# GRPC is the general RPC module
module GRPC
  # Inject the noop #logger if no module-level logger method has been injected.
  extend RubyLogger
end

require 'active_record'
require 'active_record/vitess_shard_assistant'

config = {
    adapter: :vitess,
    host: 'localhost',
    database: 'test_keyspace',
    vtgate_config: { host: '192.168.99.100:15002' },
    vtctl_config:  { host: 'localhost:15999', keyspace: 'test_keyspace' }
}

ActiveRecord::Base.establish_connection(config)

