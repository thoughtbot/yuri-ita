require "yuriita/clauses/merge"

module Yuriita
  class Sorter
    def initialize(matcher:, &block)
      @matcher = matcher
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

    attr_reader :matcher, :block

    def matches?(input)
      matcher.match?(input)
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
