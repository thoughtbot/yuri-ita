module Yuriita
  class SearchFilter
    attr_reader :input

    def initialize(input:, combination:, &block)
      @input = input
      @combination = combination
      @block = block
    end

    def apply(relation, keywords)
      relations = keywords.map do |keyword|
        block.call(relation, keyword.to_s)
      end

      combination.new(
        base_relation: relation,
        relations: relations,
      ).combine
    end

    private

    attr_reader :combination, :block
  end
end
