module Yuriita
  class ExpressionFilter
    def initialize(matcher:, combination:, &block)
      @matcher = matcher
      @combination = combination
      @block = block
    end

    def apply(inputs)
      matching_inputs = inputs.select do |input|
        matches?(input)
      end

      if matching_inputs.any?
        [build_merge(matching_inputs)]
      else
        []
      end
    end

    private

    attr_reader :matcher, :combination, :block

    def matches?(input)
      matcher.match?(input)
    end

    def build_merge(matching_inputs)
      clauses = build_clauses(matching_inputs)
      Clauses::Merge.new(clauses: clauses, combination: combination)
    end

    def build_clauses(inputs)
      inputs.map do |input|
        Clauses::Where.new(block.call(input.term))
      end
    end
  end
end
