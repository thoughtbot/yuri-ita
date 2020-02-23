require "yuriita/clauses/merge"

module Yuriita
  class ExpressionFilter
    def initialize(matchers:, combination:, &block)
      @matchers = matchers
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

    attr_reader :matchers, :combination, :block

    def matches?(input)
      matchers.any? do |matcher|
        matcher.match?(input)
      end
    end

    def build_merge(matching_inputs)
      clauses = build_clauses(matching_inputs)
      Clauses::Merge.new(clauses: clauses, combination: combination)
    end

    def build_clauses(inputs)
      inputs.map do |input|
        if input.negated?
          Clauses::WhereNot.new(block.call(input.term))
        else
          Clauses::Where.new(block.call(input.term))
        end
      end
    end
  end
end
