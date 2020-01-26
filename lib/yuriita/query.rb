require "yuriita/executor"

module Yuriita
  class Query
    def initialize(keywords: [], expressions: [])
      @keywords = keywords
      @expressions = expressions
    end

    def apply(definition, **options)
      clauses = definition.extract(expressions)

      executor = options.fetch(:executor, Executor)
      executor.new(clauses: clauses)
    end

    private

    attr_reader :expressions
  end
end
