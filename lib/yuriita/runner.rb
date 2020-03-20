module Yuriita
  class Runner
    def initialize(relation:, definition:, **options)
      @relation = relation
      @definition = definition
      @executor = options.fetch(:executor, Executor)
      @assembler = options.fetch(:assembler, Assembler)
    end

    def run(query)
      clauses = assembler.new(definition).build(query)
      executor.new(clauses).run(relation)
    end

    private

    attr_reader :relation, :definition, :executor, :assembler
  end
end
