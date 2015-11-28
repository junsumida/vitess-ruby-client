current_dir = File.expand_path(File.dirname(__FILE__))
proto_dir   = File.join(current_dir + '/lib/vitessproto')
$LOAD_PATH.unshift(current_dir)
$LOAD_PATH.unshift(proto_dir)

require 'google/protobuf'

require 'proto/query'
require 'proto/vtgate'
require 'proto/vtgateservice'

# Util
require 'socket'

# debug
require 'pry-byebug'

module Vitess
  class Util
    NETWORK_INTERFACE_NAMES = ["eth0", "en0"]

    class << self
      def process_id
        Process.pid
      end

      def local_ip_address
        Socket.getifaddrs.select(&:broadaddr).find{ |ip_addr| NETWORK_INTERFACE_NAMES.include?(ip_addr.name) && ip_addr.addr.ipv4? }
      end
    end
  end

  class Client
    class << self
      attr_accessor :host

      def host
      'localhost:15999'
      end

      def connect
        # vtgatesservice.begin(Vtgateservice::BeginRequest.new(caller_id: caller_id(:connect)))
      end

      def end
      end

      def query(sql, options = {})
        session = Vtgate::Session.new
        vtgateservice.execute(Vtgate::ExecuteRequest.new({caller_id: caller_id(:query), session: session, query: bound_query(sql)}))
      end

      private

      def bound_query(sql)
        Query::BoundQuery.new(sql: sql,bind_variables: {})
      end

      def vtgateservice
        @vtgatesservice ||= Vtgate::Stub.new(host)
      end

      def caller_id(method_name="", options: {})
        # FIXME : handle with possible exceptions
        principal = Vitess::Util.local_ip_address.addr.ip_address.encode("UTF-8")
        component = "process_id: #{Vitess::Util.process_id.to_s}"
        Vtrpc::CallerID.new({principal: principal, component: component, subcomponent: method_name.to_s})
      end
    end
  end
end

response = Vitess::Client.query('SELECT * FROM test_table LIMIT 5;')
p response.result
