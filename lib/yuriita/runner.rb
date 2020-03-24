module Yuriita
  class Runner
    def initialize(relation:, configuration:, **options)
      @relation = relation
      @configuration = configuration
      @executor = options.fetch(:executor, Executor)
      @assembler = options.fetch(:assembler, Assembler)
    end

    def run(query)
      clauses = assembler.new(configuration).build(query)
      executor.new(clauses).run(relation)
    end

    private

    attr_reader :relation, :configuration, :executor, :assembler
  end
end
