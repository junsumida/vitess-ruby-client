# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: tableacl.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "vitess.tableacl.TableGroupSpec" do
    optional :name, :string, 1
    repeated :table_names_or_prefixes, :string, 2
    repeated :readers, :string, 3
    repeated :writers, :string, 4
    repeated :admins, :string, 5
  end
  add_message "vitess.tableacl.Config" do
    repeated :table_groups, :message, 1, "vitess.tableacl.TableGroupSpec"
  end
end

module Vitess
  module Tableacl
    TableGroupSpec = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.tableacl.TableGroupSpec").msgclass
    Config = Google::Protobuf::DescriptorPool.generated_pool.lookup("vitess.tableacl.Config").msgclass
  end
end
