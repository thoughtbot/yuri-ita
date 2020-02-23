module Yuriita
  class OrCombination
    def initialize(relations:)
      @relations = relations
    end

    def combine
      relations.reduce do |chain, clause|
        chain.or(clause)
      end
    end

    private

    attr_reader :relations
  end
end
