module Yuriita
  class Assembler
    def initialize(definition)
      @definition = definition
    end

    def build(query)
      expression_clauses(query.expressions)
    end

    private

    attr_reader :definition

    def expression_clauses(expressions)
      filters.flat_map do |filter|
        filter.apply(expressions)
      end
    end

    def filters
      definition.filters
    end
  end
end
