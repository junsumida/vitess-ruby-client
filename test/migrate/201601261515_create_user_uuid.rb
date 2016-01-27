require 'active_record'

class CreateUserUuid < ActiveRecord::Migration
  def self.up
    create_table :user_uuids do |t|
      t.bigint :user_id
      t.string :uuid, null: false
    end
  end

  def self.down
    drop_table :user_uuids
  end
end