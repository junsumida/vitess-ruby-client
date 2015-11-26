this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require_relative 'client/version'
require_relative 'proto/vtgateservice_services'
require_relative 'proto/vtrpc'

# Util
require 'socket'

module Vitess
  class Util
    NETWORK_INTERFACE_NAMES = ["eth0", "en0"]

    class << self
      def process_id
        Proc.id
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
        'localhost:50051'
      end

      def connect
        # vtgatesservice.begin(Vtgateservice::BeginRequest.new(caller_id: caller_id(:connect)))
      end

      def end
      end

      def session
        connect.session
      end

      def query(sql, options = {})
        vtgateservice.execute(Vtgateservice::Request.new({caller_id: caller_id(:query), session: session, query: bound_query(sql)}))
      end

      private

      def bound_query(sql)
        Vtgateservice::BoundQuery.new(sql: sql,bind_variables: {})
      end

      def vtgateservice
        @vtgatesservice ||= Vtgateservice::Vitess::Service::Stub.new(host)
      end

      def caller_id(method_name: "", options: {})
        Vtrpc::CallerID.new(principal: Vitess::Util.local_ip_address, component: Vitess::Util.process_id, subcomponent: method_name)
      end
    end
  end
end

connection = Vitess::Client.connect
session  = connection.session
response = Vitess::Client.query('SELECT * FROM USERS LIMIT 5;')
p response.result
