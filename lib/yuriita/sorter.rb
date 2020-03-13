require "yuriita/clauses/merge"

module Yuriita
  class Sorter
    def initialize(matchers:, &block)
      @matchers = matchers
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

    attr_reader :matchers, :block

    def matches?(input)
      matchers.any? do |matcher|
        matcher.match?(input)
      end
    end
    def build_merge(matching_inputs)
      clauses = build_clauses(matching_inputs)
      Clauses::Merge.new(clauses: clauses, combination: Yuriita::AndCombination)
    end

    def build_clauses(inputs)
      inputs.map do |input|
        Clauses::Order.new(block.call(input.term))
      end
    end
  end
end
