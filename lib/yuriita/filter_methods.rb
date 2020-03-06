require "yuriita/runner"

module Yuriita
  module FilterMethods

    def filter(relation, query, options = {})
      definition = options.fetch(:definition)

      runner = Runner.new(
        relation: relation,
        definition: definition,
      )

      runner.run(query)
    end
  end
end
