module Yuriita
  class Query
    class Fragment
      attr_reader :keywords, :expression_inputs, :scope_inputs

      def initialize(keywords: [], expression_inputs: [], scope_inputs: [])
        @keywords = keywords
        @expression_inputs = expression_inputs
        @scope_inputs = scope_inputs
      end

      def merge(other)
        Fragment.new(
          keywords: keywords + other.keywords,
          expression_inputs: expression_inputs + other.expression_inputs,
          scope_inputs: scope_inputs + other.scope_inputs,
        )
      end
    end
  end
end
