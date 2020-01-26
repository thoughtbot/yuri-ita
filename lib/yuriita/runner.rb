require "yuriita/parser"
require "yuriita/lexer"
require "yuriita/result"

module Yuriita
  class Runner
    def initialize(relation:, definition:, **options)
      @relation = relation
      @definition = definition
      @parser = options.fetch(:parser, Parser)
      @lexer = options.fetch(:lexer, Lexer)
    end

    def run(query_string)
      executor = query(query_string).apply(definition)
      Result.success(executor.run(relation))
    rescue RLTK::LexingError, RLTK::NotInLanguage, RLTK::BadToken, EOFError => e
      Result.error(e)
    end

    private

    attr_reader :lexer, :parser, :definition, :relation

    def query(input)
      tokens = lexer.lex(input)
      parser.parse(tokens)
    end
  end
end
