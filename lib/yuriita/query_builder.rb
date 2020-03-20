module Yuriita
  class QueryBuilder
    def self.build(input)
      new.build(input)
    end

    def initialize(lexer: Lexer, parser: Parser)
      @lexer = Lexer
      @parser = Parser
    end

    def build(input)
      tokens = lexer.lex(input)
      parser.parse(tokens)
    rescue RLTK::LexingError, RLTK::NotInLanguage, RLTK::BadToken, EOFError
      raise ParseError
    end

    private

    attr_reader :lexer, :parser
  end
end
