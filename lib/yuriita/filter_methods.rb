require "yuriita/runner"

module Yuriita
  module FilterMethods

    def filter(relation, query, options = {})
      query_definition = options.fetch(:query_definition)

      runner = Runner.new(
        relation: relation,
        definition: query_definition,
      )

      runner.run(query)
    end
  end
end
