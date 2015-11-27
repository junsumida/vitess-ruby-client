# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: vtrpc.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "vitess.vtrpc.CallerID" do
    optional :principal, :string, 1
    optional :component, :string, 2
    optional :subcomponent, :string, 3
  end
  add_message "vitess.vtrpc.RPCError" do
    optional :code, :enum, 1, "vitess.vtrpc.ErrorCode"
    optional :message, :string, 2
  end
  add_enum "vitess.vtrpc.ErrorCode" do
    value :SUCCESS, 0
    value :CANCELLED, 1
    value :UNKNOWN_ERROR, 2
    value :BAD_INPUT, 3
    value :DEADLINE_EXCEEDED, 4
    value :INTEGRITY_ERROR, 5
    value :PERMISSION_DENIED, 6
    value :RESOURCE_EXHAUSTED, 7
    value :QUERY_NOT_SERVED, 8
    value :NOT_IN_TX, 9
    value :INTERNAL_ERROR, 10
    value :TRANSIENT_ERROR, 11
    value :UNAUTHENTICATED, 12
  end
end

module Vitess
  module Vtrpc
    CallerID = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtrpc.CallerID").msgclass
    RPCError = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtrpc.RPCError").msgclass
    ErrorCode = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtrpc.ErrorCode").enummodule
  end
end
