require "active_support/concern"
require "active_support/core_ext/class/attribute"

require "yuriita/definition/fixed_condition_builder"
require "yuriita/definition/custom_condition_builder"

require "yuriita/query_definition"

module Yuriita
  module Definition
    module Methods
      extend ActiveSupport::Concern

      included do
        extend ClassMethods

        class_attribute :_filters, default: []
      end

      module ClassMethods
        def filters
          _filters
        end

        def fixed(*args)
          self._filters += FixedConditionBuilder.new(*args).build
        end

        def value(*args, &block)
          if block_given?
            self._filters += CustomConditionBuilder.new(*args, &block).build
          else
            self._filters += ValueConditionBuilder.new(*args).build
          end
        end

        def to_definition
          QueryDefinition.new(filters: _filters)
        end
      end
    end
  end
end
