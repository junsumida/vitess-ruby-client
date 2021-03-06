require 'active_support/core_ext/class/attribute'

module ActiveRecord
  module VitessShardAssistant
    def self.extended(base_class)
      base_class.class_attribute(:shard_column)
      base_class.extend(ClassMethods)
    end

    module ClassMethods
      def shard_key(column_name)
        self.shard_column = column_name.to_s
      end

      def sharded?
        self.shard_column.present?
      end
    end

    extend ClassMethods
  end

  # Monkey Patches
  module Persistence
    alias_method :_old_update_record, :_update_record
    alias_method :_old_reload, :reload

    def _update_record(attribute_names = self.attribute_names)
      attributes_values = arel_attributes_with_values_for_update(attribute_names)

      if attributes_values.empty?
        0
      else
        self.class.unscoped._update_record attributes_values, id, id_was, self[self.shard_column.to_sym]
      end
    end

    def reload(options = nil)
      clear_aggregation_cache
      clear_association_cache
      self.class.connection.clear_query_cache

      fresh_object =
        if options && options[:lock]
          rel = self.class.lock(options[:lock]).where(id: id)
          rel = rel.where(shard_column => self[shard_column]) unless shard_column.nil?
          self.class.unscoped { rel.first }
        else
          rel = self.class.where(id: id)
          rel = rel.where(shard_column => self[shard_column]) unless shard_column.nil?
          self.class.unscoped { rel.first }
        end

      @attributes = fresh_object.instance_variable_get('@attributes')
      @new_record = false
      self
    end
  end

  class Relation
    alias_method :_old_update_record, :_update_record

    def _update_record(values, id, id_was, shard_key = nil) # :nodoc:
      substitutes, binds = substitute_values values

      scope = @klass.unscoped

      if @klass.finder_needs_type_condition?
        scope.unscope!(where: @klass.inheritance_column)
      end

      fail NoShardKeyError if shard_key.nil? && !@klass.sharded?

      relation = scope.where(@klass.primary_key => (id_was || id))
      relation = relation.where(@klass.shard_column => shard_key) if @klass.sharded?
      bvs = binds + relation.bind_values
      um = relation
        .arel
        .compile_update(substitutes, @klass.primary_key)

      @klass.connection.update(
        um,
        'SQL',
        bvs,
      )
    end
  end



  class NoShardKeyError < StandardError; end
end

ActiveRecord::Base.extend(ActiveRecord::VitessShardAssistant)
