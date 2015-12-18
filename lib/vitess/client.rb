current_dir = File.expand_path(File.dirname(__FILE__))
proto_dir   = File.join(current_dir + '/lib/vitessproto')
$LOAD_PATH.unshift(current_dir)
$LOAD_PATH.unshift(proto_dir)

require 'google/protobuf'

require 'proto/query'
require 'proto/vtgate'
require 'proto/vtgateservice'

# load Vtctl
require 'vtctl/client'

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
    attr_reader :vtgate_service

    def initialize(host:'localhost:15002')
      @vtgate_service = Vtgate::Stub.new(host)
      @session        = Vtgate::Session.new
    end

    def command(session=nil)
      resp = yield
      @session = session.nil? ? resp.session : session
      resp
    end

    def begin
      command { vtgate_service.begin(Vtgate::BeginRequest.new(caller_id: caller_id(:connect))) }
    end

    def commit(args={})
      command(Vtgate::Session.new) { vtgate_service.commit(Vtgate::CommitRequest.new(session: @session)) }
    end

    def rollback
      command(Vtgate::Session.new) { vtgate_service.rollback(Vtgate::RollbackRequest.new(session: @session, caller_id: caller_id(:rollback))) }
    end

    def get_server_keyspace(keyspace_name='')
      command { vtgate_service.get_srv_keyspace(Vtgate::GetSrvKeyspaceRequest.new({ keyspace: keyspace_name })) }
    end

    def query(sql, tablet_type: 1)
      command {
        vtgate_service.execute(Vtgate::ExecuteRequest.new({ caller_id: caller_id(:query), session: @session, query: bound_query(sql), tablet_type: tablet_type}))
      }
    end

    def query_with_keyspace_ids(sql, keyspace: "")
      args    = {
        caller_id: caller_id(:query_with_keyspace_ids),
        session:   @session,
        query:     bound_query(sql),
        keyspace:  keyspace,
        keyspace_ids: ['0'.encode('ASCII-8BIT')],
        tablet_type: 1
      }
      request = Vtgate::ExecuteKeyspaceIdsRequest.new(args)
      command { vtgate_service.execute_keyspace_ids(request) }
    end

    private

    def bound_query(sql)
      Query::BoundQuery.new(sql: sql,bind_variables: {})
    end

    def caller_id(method_name="", options: {})
      # FIXME : need to handle potentially possible exceptions
      principal = Vitess::Util.local_ip_address.addr.ip_address.encode("UTF-8")
      component = "process_id: #{Vitess::Util.process_id.to_s}"
      Vtrpc::CallerID.new({principal: principal, component: component, subcomponent: method_name.to_s})
    end
  end
end

