require "yuriita/search_assembler"

module Yuriita
  class Assembler
    def initialize(definition, search_assembler: SearchAssembler)
      @definition = definition
      @search_assembler = search_assembler
    end

    def build(query)
      filter_clauses(query.expressions) + keyword_search_clauses(query)
    end

    private

    attr_reader :definition, :search_assembler

    def filter_clauses(expressions)
      filters.flat_map do |filter|
        filter.apply(expressions)
      end
    end

    def keyword_search_clauses(query)
      search_assembler.new(
        keyword_searches: keyword_searches,
        keywords: query.keywords,
        scopes: query.scopes,
      ).assemble
    end

    def filters
      definition.filters
    end

    def keyword_searches
      definition.searches
    end
  end
end
