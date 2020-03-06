require "yuriita/keyword_filter_assembler"

module Yuriita
  class Assembler
    def initialize(definition, keyword_filter_assembler: KeywordFilterAssembler)
      @definition = definition
      @keyword_filter_assembler = keyword_filter_assembler
    end

    def build(query)
      expression_filter_clauses(query.expression_inputs) + keyword_filter_clauses(query)
    end

    private

    attr_reader :definition, :keyword_filter_assembler

    def expression_filter_clauses(expression_inputs)
      expression_filters.flat_map do |expression_filter|
        expression_filter.apply(expression_inputs)
      end
    end

    def keyword_filter_clauses(query)
      keyword_filter_assembler.new(
        keyword_filters: keyword_filters,
        keywords: query.keywords,
        scope_inputs: query.scope_inputs,
      ).assemble
    end

    def expression_filters
      definition.expression_filters
    end

    def keyword_filters
      definition.keyword_filters
    end
  end
end
