current_dir = File.expand_path(File.dirname(__FILE__))
proto_dir   = File.join(current_dir + '/lib/vitessproto')
$LOAD_PATH.unshift(current_dir)
$LOAD_PATH.unshift(proto_dir)

require 'google/protobuf'
require 'grpc'

require 'proto/query'
require 'proto/vtgate'
require 'proto/vtgateservice'

require 'logger'

# RubyLogger defines a logger for gRPC based on the standard ruby logger.
module RubyLogger
  def logger
    LOGGER
  end

  LOGGER = Logger.new(STDOUT)
  LOGGER.level = Logger::DEBUG
end

# GRPC is the general RPC module
module GRPC
  # Inject the noop #logger if no module-level logger method has been injected.
  extend RubyLogger
end

module Vitess
  class VtgateServer < Vtgate::Service
    def execute(request, _call)
      row    = Query::Row.new(lengths: [1], values: 'hogehoge'.force_encode("ASCII-8BIT\n"))
      field  = Query::Field.new(name: 'name', type: Query::Type::VARCHAR)
      result = Query::QueryResult.new(fields: [field, field], rows_affected: 1, insert_id: 1, rows: [row, row])
      RubyLogger::LOGGER.info row.values
      Query::ExecuteResponse.new(result: result)
    end

    def begin(request, _call)
    end

    def execute_keyspace_ids(request, _call)
    end
  end
end

s = GRPC::RpcServer.new
s.add_http2_port("localhost:45678", :this_port_is_insecure)
#Logger.info("... running insecurely on #{port}")
s.handle(Vitess::VtgateServer)
s.run_till_terminated
