module Yuriita
  class AndCombination
    def initialize(relations:)
      @relations = relations
    end

    def combine
      relations.reduce do |chain, relation|
        chain.where(relation)
      end
    end

    private

    attr_reader :relations
  end
end
