module Yuriita
  class Assembler
    def initialize(configuration)
      @configuration = configuration
    end

    def build(query)
      expression_clauses(query) + search_clauses(query)
    end

    private

    attr_reader :configuration

    def expression_clauses(query)
      configuration.definitions.each_value.map do |definition|
        definition.apply(query: query)
      end
    end

    def search_clauses(query)
      configuration.scopes.each_value.map do |collection|
        collection.apply(query: query)
      end
    end
  end
end
