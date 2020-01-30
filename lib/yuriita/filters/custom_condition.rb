require "yuriita/clauses/where"
require "yuriita/clauses/where_not"
require "yuriita/clauses/noop"

module Yuriita
  module Filters
    class CustomCondition
      def initialize(qualifiers:, &block)
        @qualifiers = qualifiers.map(&:to_s)
        @block = block
      end

      def apply(expression)
        if matches?(expression)
          build_clause(expression)
        else
          Clauses::Noop.new
        end
      end

      private

      attr_reader :qualifiers, :block

      def matches?(candidate)
        qualifiers.include?(candidate.qualifier)
      end

      def build_clause(expression)
        if expression.negated?
          Clauses::WhereNot.new(block.call(expression.term))
        else
          Clauses::Where.new(block.call(expression.term))
        end
      end
    end
  end
end
