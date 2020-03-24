module Yuriita
  class SearchFilter
    def initialize(matcher:, combination:, &block)
      @matcher = matcher
      @combination = combination
      @block = block
    end

    def matches?(inputs)
      inputs.any? do |input|
        matches_input?(input)
      end
    end

    def apply(relation, keywords)
      relations = keywords.map do |keyword|
        block.call(relation, keyword)
      end

      combination.new(
        base_relation: relation,
        relations: relations,
      ).combine
    end

    def build_input
      matcher.build_input
    end

    private

    attr_reader :matcher, :combination, :block

    def matches_input?(input)
      matcher.match?(input)
    end
  end
end
