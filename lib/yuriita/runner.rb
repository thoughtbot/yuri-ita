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
      @parser = options.fetch(:parser, Parser)
      @lexer = options.fetch(:lexer, Lexer)
      @executor = options.fetch(:executor, Executor)
      @assembler = options.fetch(:assembler, Assembler)
    end

    def run(input)
      query = build_query(input)
      clauses = assembler.new(definition).build(query)
      filtered = executor.new(clauses).run(relation)

      Result.success(filtered)
    rescue RLTK::LexingError, RLTK::NotInLanguage, RLTK::BadToken, EOFError => e
      Result.error(e)
    end

    private

    attr_reader :lexer, :parser, :executor, :definition, :relation, :assembler

    def build_query(input)
      tokens = lexer.lex(input)
      parser.parse(tokens)
    end
  end
end
