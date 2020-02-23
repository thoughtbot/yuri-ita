module Yuriita
  class AndCombination
    def initialize(relations:)
      @relations = relations
    end

    def combine
      relations.reduce do |chain, clause|
        chain.where(clause)
      end
    end

    private

    attr_reader :relations
  end
end
