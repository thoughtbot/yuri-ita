module Yuriita
  class Executor
    def initialize(clauses:)
      @clauses = clauses
    end

    def run(relation)
      filter(relation)
    end

    private

    attr_reader :clauses

    def filter(relation)
      clauses.reduce(relation) do |memo, clause|
        clause.call(memo)
      end
    end
  end
end
