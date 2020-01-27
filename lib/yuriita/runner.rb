require "yuriita/parser"
require "yuriita/lexer"
require "yuriita/result"
require "yuriita/executor"

module Yuriita
  class Runner
    def initialize(relation:, definition:, **options)
      @relation = relation
      @definition = definition
      @parser = options.fetch(:parser, Parser)
      @lexer = options.fetch(:lexer, Lexer)
      @executor = options.fetch(:executor, Executor)
    end

    def run(input)
      query = build_query(input)
      clauses = definition.extract(query.expressions)
      filtered = filtered_relation(clauses)

      Result.success(filtered)
    rescue RLTK::LexingError, RLTK::NotInLanguage, RLTK::BadToken, EOFError => e
      Result.error(e)
    end

    private

    attr_reader :lexer, :parser, :executor, :definition, :relation

    def build_query(input)
      tokens = lexer.lex(input)
      parser.parse(tokens)
    end

    def filtered_relation(clauses)
      executor.new(clauses: clauses).run(relation)
    end
  end
end
