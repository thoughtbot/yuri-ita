module Yuriita
  class Executor
    def initialize(clauses)
      @clauses = clauses
    end

    def run(relation)
      clauses.reduce(relation) do |chain, scope|
        # To execute, we need:
        # - The relation
        # - For each collection we need:
        #   - The combination
        #   - The list of selected filters for the combination
        #   - (Maybe) the matching inputs for each filter.
        #     This is the confusing part, because what if multiple inputs match?
        #     Do we call the filter once per matching input?
        # What do we call this thing? This could be what the assembler returns.
        # It would allow us to find a common interface for the exector maybe?
        scope.apply(chain)
      end
    end

    private

    attr_reader :clauses
  end
end
