require 'google/protobuf'

require 'proto/vtctldata'
require 'proto/vtctlservice_services'

module Vitess
  module Vtctl
    module Generic
      def list_all_tablets(cell_name)
        execute(args: ['ListAllTablets', cell_name])
      end
    end

    module Keyspace
      def create_keyspace(keyspace_name)
        execute(args: ['CreateKeyspace', keyspace_name])
      end

      def get_keyspace(keyspace_name)
        execute(args: ['GetKeyspace', keyspace_name])
      end

      def delete_keyspacce(keyspace_name)
        execute(args: ['DeleteKeyspace', keyspace_name])
      end
    end

    module Schema
      def apply_schema(sql, keyspace_name=nil)
        ArgumentError if @default_keyspace.nil? && keyspace_name.nil?
        execute(args: ['ApplySchema', "-sql=#{sql}", keyspace_name || @default_keyspace])
      end
    end

    class Client
      include Generic
      include Keyspace
      include Schema

      attr_reader :vtctl_service

      def initialize(host: '', keyspace: '')
        @default_keyspace = (keyspace == '' || keyspace.nil?) ? nil : keyspace
        @vtctl_service = ::Vtctl::Stub.new(host)
      end

      def execute(args)
        vtctl_service.execute_vtctl_command(Vtctldata::ExecuteVtctlCommandRequest.new(args))
      end
    end
  end
end