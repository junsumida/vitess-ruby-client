# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: vtgate.proto

require 'google/protobuf'

require 'query'
require 'topodata'
require 'vtrpc'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "vitess.vtgate.Session" do
    optional :in_transaction, :bool, 1
    repeated :shard_sessions, :message, 2, "vitess.vtgate.Session.ShardSession"
  end
  add_message "vitess.vtgate.Session.ShardSession" do
    optional :target, :message, 1, "vitess.query.Target"
    optional :transaction_id, :int64, 2
  end
  add_message "vitess.vtgate.ExecuteRequest" do
    optional :caller_id, :message, 1, "vitess.vtrpc.CallerID"
    optional :session, :message, 2, "vitess.vtgate.Session"
    optional :query, :message, 3, "vitess.query.BoundQuery"
    optional :tablet_type, :enum, 4, "vitess.topodata.TabletType"
    optional :not_in_transaction, :bool, 5
  end
  add_message "vitess.vtgate.ExecuteResponse" do
    optional :error, :message, 1, "vitess.vtrpc.RPCError"
    optional :session, :message, 2, "vitess.vtgate.Session"
    optional :result, :message, 3, "vitess.query.QueryResult"
  end
  add_message "vitess.vtgate.ExecuteShardsRequest" do
    optional :caller_id, :message, 1, "vitess.vtrpc.CallerID"
    optional :session, :message, 2, "vitess.vtgate.Session"
    optional :query, :message, 3, "vitess.query.BoundQuery"
    optional :keyspace, :string, 4
    repeated :shards, :string, 5
    optional :tablet_type, :enum, 6, "vitess.topodata.TabletType"
    optional :not_in_transaction, :bool, 7
  end
  add_message "vitess.vtgate.ExecuteShardsResponse" do
    optional :error, :message, 1, "vitess.vtrpc.RPCError"
    optional :session, :message, 2, "vitess.vtgate.Session"
    optional :result, :message, 3, "vitess.query.QueryResult"
  end
  add_message "vitess.vtgate.ExecuteKeyspaceIdsRequest" do
    optional :caller_id, :message, 1, "vitess.vtrpc.CallerID"
    optional :session, :message, 2, "vitess.vtgate.Session"
    optional :query, :message, 3, "vitess.query.BoundQuery"
    optional :keyspace, :string, 4
    repeated :keyspace_ids, :bytes, 5
    optional :tablet_type, :enum, 6, "vitess.topodata.TabletType"
    optional :not_in_transaction, :bool, 7
  end
  add_message "vitess.vtgate.ExecuteKeyspaceIdsResponse" do
    optional :error, :message, 1, "vitess.vtrpc.RPCError"
    optional :session, :message, 2, "vitess.vtgate.Session"
    optional :result, :message, 3, "vitess.query.QueryResult"
  end
  add_message "vitess.vtgate.ExecuteKeyRangesRequest" do
    optional :caller_id, :message, 1, "vitess.vtrpc.CallerID"
    optional :session, :message, 2, "vitess.vtgate.Session"
    optional :query, :message, 3, "vitess.query.BoundQuery"
    optional :keyspace, :string, 4
    repeated :key_ranges, :message, 5, "vitess.topodata.KeyRange"
    optional :tablet_type, :enum, 6, "vitess.topodata.TabletType"
    optional :not_in_transaction, :bool, 7
  end
  add_message "vitess.vtgate.ExecuteKeyRangesResponse" do
    optional :error, :message, 1, "vitess.vtrpc.RPCError"
    optional :session, :message, 2, "vitess.vtgate.Session"
    optional :result, :message, 3, "vitess.query.QueryResult"
  end
  add_message "vitess.vtgate.ExecuteEntityIdsRequest" do
    optional :caller_id, :message, 1, "vitess.vtrpc.CallerID"
    optional :session, :message, 2, "vitess.vtgate.Session"
    optional :query, :message, 3, "vitess.query.BoundQuery"
    optional :keyspace, :string, 4
    optional :entity_column_name, :string, 5
    repeated :entity_keyspace_ids, :message, 6, "vitess.vtgate.ExecuteEntityIdsRequest.EntityId"
    optional :tablet_type, :enum, 7, "vitess.topodata.TabletType"
    optional :not_in_transaction, :bool, 8
  end
  add_message "vitess.vtgate.ExecuteEntityIdsRequest.EntityId" do
    optional :xid_type, :enum, 1, "vitess.query.Type"
    optional :xid_value, :bytes, 2
    optional :keyspace_id, :bytes, 3
  end
  add_message "vitess.vtgate.ExecuteEntityIdsResponse" do
    optional :error, :message, 1, "vitess.vtrpc.RPCError"
    optional :session, :message, 2, "vitess.vtgate.Session"
    optional :result, :message, 3, "vitess.query.QueryResult"
  end
  add_message "vitess.vtgate.BoundShardQuery" do
    optional :query, :message, 1, "vitess.query.BoundQuery"
    optional :keyspace, :string, 2
    repeated :shards, :string, 3
  end
  add_message "vitess.vtgate.ExecuteBatchShardsRequest" do
    optional :caller_id, :message, 1, "vitess.vtrpc.CallerID"
    optional :session, :message, 2, "vitess.vtgate.Session"
    repeated :queries, :message, 3, "vitess.vtgate.BoundShardQuery"
    optional :tablet_type, :enum, 4, "vitess.topodata.TabletType"
    optional :as_transaction, :bool, 5
  end
  add_message "vitess.vtgate.ExecuteBatchShardsResponse" do
    optional :error, :message, 1, "vitess.vtrpc.RPCError"
    optional :session, :message, 2, "vitess.vtgate.Session"
    repeated :results, :message, 3, "vitess.query.QueryResult"
  end
  add_message "vitess.vtgate.BoundKeyspaceIdQuery" do
    optional :query, :message, 1, "vitess.query.BoundQuery"
    optional :keyspace, :string, 2
    repeated :keyspace_ids, :bytes, 3
  end
  add_message "vitess.vtgate.ExecuteBatchKeyspaceIdsRequest" do
    optional :caller_id, :message, 1, "vitess.vtrpc.CallerID"
    optional :session, :message, 2, "vitess.vtgate.Session"
    repeated :queries, :message, 3, "vitess.vtgate.BoundKeyspaceIdQuery"
    optional :tablet_type, :enum, 4, "vitess.topodata.TabletType"
    optional :as_transaction, :bool, 5
  end
  add_message "vitess.vtgate.ExecuteBatchKeyspaceIdsResponse" do
    optional :error, :message, 1, "vitess.vtrpc.RPCError"
    optional :session, :message, 2, "vitess.vtgate.Session"
    repeated :results, :message, 3, "vitess.query.QueryResult"
  end
  add_message "vitess.vtgate.StreamExecuteRequest" do
    optional :caller_id, :message, 1, "vitess.vtrpc.CallerID"
    optional :query, :message, 2, "vitess.query.BoundQuery"
    optional :tablet_type, :enum, 3, "vitess.topodata.TabletType"
  end
  add_message "vitess.vtgate.StreamExecuteResponse" do
    optional :result, :message, 1, "vitess.query.QueryResult"
  end
  add_message "vitess.vtgate.StreamExecuteShardsRequest" do
    optional :caller_id, :message, 1, "vitess.vtrpc.CallerID"
    optional :query, :message, 2, "vitess.query.BoundQuery"
    optional :keyspace, :string, 3
    repeated :shards, :string, 4
    optional :tablet_type, :enum, 5, "vitess.topodata.TabletType"
  end
  add_message "vitess.vtgate.StreamExecuteShardsResponse" do
    optional :result, :message, 1, "vitess.query.QueryResult"
  end
  add_message "vitess.vtgate.StreamExecuteKeyspaceIdsRequest" do
    optional :caller_id, :message, 1, "vitess.vtrpc.CallerID"
    optional :query, :message, 2, "vitess.query.BoundQuery"
    optional :keyspace, :string, 3
    repeated :keyspace_ids, :bytes, 4
    optional :tablet_type, :enum, 5, "vitess.topodata.TabletType"
  end
  add_message "vitess.vtgate.StreamExecuteKeyspaceIdsResponse" do
    optional :result, :message, 1, "vitess.query.QueryResult"
  end
  add_message "vitess.vtgate.StreamExecuteKeyRangesRequest" do
    optional :caller_id, :message, 1, "vitess.vtrpc.CallerID"
    optional :query, :message, 2, "vitess.query.BoundQuery"
    optional :keyspace, :string, 3
    repeated :key_ranges, :message, 4, "vitess.topodata.KeyRange"
    optional :tablet_type, :enum, 5, "vitess.topodata.TabletType"
  end
  add_message "vitess.vtgate.StreamExecuteKeyRangesResponse" do
    optional :result, :message, 1, "vitess.query.QueryResult"
  end
  add_message "vitess.vtgate.BeginRequest" do
    optional :caller_id, :message, 1, "vitess.vtrpc.CallerID"
  end
  add_message "vitess.vtgate.BeginResponse" do
    optional :session, :message, 1, "vitess.vtgate.Session"
  end
  add_message "vitess.vtgate.CommitRequest" do
    optional :caller_id, :message, 1, "vitess.vtrpc.CallerID"
    optional :session, :message, 2, "vitess.vtgate.Session"
  end
  add_message "vitess.vtgate.CommitResponse" do
  end
  add_message "vitess.vtgate.RollbackRequest" do
    optional :caller_id, :message, 1, "vitess.vtrpc.CallerID"
    optional :session, :message, 2, "vitess.vtgate.Session"
  end
  add_message "vitess.vtgate.RollbackResponse" do
  end
  add_message "vitess.vtgate.SplitQueryRequest" do
    optional :caller_id, :message, 1, "vitess.vtrpc.CallerID"
    optional :keyspace, :string, 2
    optional :query, :message, 3, "vitess.query.BoundQuery"
    optional :split_column, :string, 4
    optional :split_count, :int64, 5
  end
  add_message "vitess.vtgate.SplitQueryResponse" do
    repeated :splits, :message, 1, "vitess.vtgate.SplitQueryResponse.Part"
  end
  add_message "vitess.vtgate.SplitQueryResponse.KeyRangePart" do
    optional :keyspace, :string, 1
    repeated :key_ranges, :message, 2, "vitess.topodata.KeyRange"
  end
  add_message "vitess.vtgate.SplitQueryResponse.ShardPart" do
    optional :keyspace, :string, 1
    repeated :shards, :string, 2
  end
  add_message "vitess.vtgate.SplitQueryResponse.Part" do
    optional :query, :message, 1, "vitess.query.BoundQuery"
    optional :key_range_part, :message, 2, "vitess.vtgate.SplitQueryResponse.KeyRangePart"
    optional :shard_part, :message, 3, "vitess.vtgate.SplitQueryResponse.ShardPart"
    optional :size, :int64, 4
  end
  add_message "vitess.vtgate.GetSrvKeyspaceRequest" do
    optional :keyspace, :string, 1
  end
  add_message "vitess.vtgate.GetSrvKeyspaceResponse" do
    optional :srv_keyspace, :message, 1, "vitess.topodata.SrvKeyspace"
  end
end

module Vitess
  module Vtgate
    Session = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.Session").msgclass
    Session::ShardSession = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.Session.ShardSession").msgclass
    ExecuteRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.ExecuteRequest").msgclass
    ExecuteResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.ExecuteResponse").msgclass
    ExecuteShardsRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.ExecuteShardsRequest").msgclass
    ExecuteShardsResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.ExecuteShardsResponse").msgclass
    ExecuteKeyspaceIdsRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.ExecuteKeyspaceIdsRequest").msgclass
    ExecuteKeyspaceIdsResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.ExecuteKeyspaceIdsResponse").msgclass
    ExecuteKeyRangesRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.ExecuteKeyRangesRequest").msgclass
    ExecuteKeyRangesResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.ExecuteKeyRangesResponse").msgclass
    ExecuteEntityIdsRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.ExecuteEntityIdsRequest").msgclass
    ExecuteEntityIdsRequest::EntityId = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.ExecuteEntityIdsRequest.EntityId").msgclass
    ExecuteEntityIdsResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.ExecuteEntityIdsResponse").msgclass
    BoundShardQuery = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.BoundShardQuery").msgclass
    ExecuteBatchShardsRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.ExecuteBatchShardsRequest").msgclass
    ExecuteBatchShardsResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.ExecuteBatchShardsResponse").msgclass
    BoundKeyspaceIdQuery = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.BoundKeyspaceIdQuery").msgclass
    ExecuteBatchKeyspaceIdsRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.ExecuteBatchKeyspaceIdsRequest").msgclass
    ExecuteBatchKeyspaceIdsResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.ExecuteBatchKeyspaceIdsResponse").msgclass
    StreamExecuteRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.StreamExecuteRequest").msgclass
    StreamExecuteResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.StreamExecuteResponse").msgclass
    StreamExecuteShardsRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.StreamExecuteShardsRequest").msgclass
    StreamExecuteShardsResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.StreamExecuteShardsResponse").msgclass
    StreamExecuteKeyspaceIdsRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.StreamExecuteKeyspaceIdsRequest").msgclass
    StreamExecuteKeyspaceIdsResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.StreamExecuteKeyspaceIdsResponse").msgclass
    StreamExecuteKeyRangesRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.StreamExecuteKeyRangesRequest").msgclass
    StreamExecuteKeyRangesResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.StreamExecuteKeyRangesResponse").msgclass
    BeginRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.BeginRequest").msgclass
    BeginResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.BeginResponse").msgclass
    CommitRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.CommitRequest").msgclass
    CommitResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.CommitResponse").msgclass
    RollbackRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.RollbackRequest").msgclass
    RollbackResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.RollbackResponse").msgclass
    SplitQueryRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.SplitQueryRequest").msgclass
    SplitQueryResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.SplitQueryResponse").msgclass
    SplitQueryResponse::KeyRangePart = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.SplitQueryResponse.KeyRangePart").msgclass
    SplitQueryResponse::ShardPart = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.SplitQueryResponse.ShardPart").msgclass
    SplitQueryResponse::Part = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.SplitQueryResponse.Part").msgclass
    GetSrvKeyspaceRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.GetSrvKeyspaceRequest").msgclass
    GetSrvKeyspaceResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.vtgate.GetSrvKeyspaceResponse").msgclass
  end
end
