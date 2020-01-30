require "yuriita/filters/fixed_condition"

module Yuriita
  module Definition
    class FixedConditionBuilder
      def initialize(*args)
        @conditions = args.extract_options!
        @expressions = args.map { |value| value.split ":" }
      end

      def build
        [build_filter]
      end

      private

      attr_reader :expressions, :conditions

      def build_filter
        Filters::FixedCondition.new(
          expressions: expressions,
          conditions: conditions,
        )
      end
    end
  end
end
