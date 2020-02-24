module Yuriita
  class OrCombination
    def initialize(relations:)
      @relations = relations
    end

    def combine
      relations.reduce do |chain, relation|
        chain.or(relation)
      end
    end

    private

    attr_reader :relations
  end
end
