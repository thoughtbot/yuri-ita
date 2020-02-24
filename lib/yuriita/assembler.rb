require "yuriita/clauses/merge"
require "yuriita/or_combination"

module Yuriita
  class Assembler
    def initialize(definition)
      @definition = definition
    end

    def build(query)
      expression_clauses(query.expressions) +
        scope_clauses(query.keywords, query.scopes)
    end

    private

    attr_reader :definition

    def expression_clauses(expressions)
      filters.flat_map do |filter|
        filter.apply(expressions)
      end
    end

    def scope_clauses(keywords, scopes)
      search_clauses = searches.flat_map do |search|
        search.apply(keywords, scopes)
      end
      if search_clauses.any?
        [
          Clauses::Merge.new(
            clauses: search_clauses,
            combination: OrCombination,
          )
        ]
      else
        []
      end
    end

    def filters
      definition.filters
    end

    def searches
      definition.searches
    end
  end
end
