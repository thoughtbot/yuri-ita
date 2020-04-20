module Yuriita
  class Executor
    def initialize(clauses)
      @clauses = clauses
    end

    def run(relation)
      clauses.reduce(relation) do |chain, clause|
        chain.merge(clause.apply(relation))
      end
    end

    private

    attr_reader :clauses
  end
end
