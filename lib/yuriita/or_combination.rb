module Yuriita
  class OrCombination
    def initialize(base_relation:, relations:)
      @base_relation = base_relation
      @relations = relations
    end

    def combine
      base_relation.merge(combined_relations)
    end

    private

    attr_reader :base_relation, :relations

    def combined_relations
      relations.reduce do |chain, relation|
        chain.or(relation)
      end
    end
  end
end

