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

    class Client
      include Generic

      attr_reader :vtctl_service

      def initialize(host: '')
        @vtctl_service = ::Vtctl::Stub.new(host)
      end

      def execute(args)
        vtctl_service.execute_vtctl_command(Vtctldata::ExecuteVtctlCommandRequest.new(args))
      end
    end
  end
end