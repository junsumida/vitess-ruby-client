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

      def initialize(host: '')
        @host = host
      end

      def execute(args)
        vtctl_service.execute_vtctl_command(Vtctldata::ExecuteVtctlCommandRequest.new(args))
      end

      private

      def vtctl_service
        @vtctl_service ||= ::Vtctl::Stub.new(@host)
      end
    end
  end
end