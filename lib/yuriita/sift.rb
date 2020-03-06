require "yuriita/runner"

module Yuriita
  module Sift

    def sift(relation, query, options = {})
      definition = options.fetch(:definition)

      runner = Runner.new(
        relation: relation,
        definition: definition,
      )

      runner.run(query)
    end
  end
end
