require "active_support/core_ext/array/extract_options"
require "yuriita/filters/value_condition"

module Yuriita
  module Definition
    class ValueConditionBuilder
      def initialize(*args)
        options = args.extract_options!
        @column = options.fetch(:column)
        @qualifiers = args.map(&:to_s)
      end

      def build
        [build_filter]
      end

      private

      attr_reader :qualifiers, :column

      def build_filter
        Filters::ValueCondition.new(
          qualifiers: qualifiers,
          column: column,
        )
      end
    end
  end
end
