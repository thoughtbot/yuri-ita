require "yuriita/filters/custom_condition"

module Yuriita
  module Definition
    class CustomConditionBuilder
      def initialize(*args, &block)
        @qualifiers = args.map(&:to_s)
        @block = block
      end

      def build
        [build_filter]
      end

      private

      attr_reader :qualifiers, :block

      def build_filter
        Filters::CustomCondition.new(qualifiers: qualifiers, &block)
      end
    end
  end
end
