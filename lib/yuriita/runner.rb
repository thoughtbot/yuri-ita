require "yuriita/parser"
require "yuriita/lexer"
require "yuriita/result"
require "yuriita/executor"
require "yuriita/assembler"

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
