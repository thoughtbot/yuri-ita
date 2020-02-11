require "rltk/lexer"

module Yuriita
  class Lexer < RLTK::Lexer
    rule(/[ \t\f]+/) { :SPACE }
    rule(/:/) { :COLON }
    rule(/in/) { :IN }
    rule(/sort/) { :SORT }
    rule(/[a-zA-Z_]+/) { |t| [:WORD, t] }
    rule(/"/) { :QUOTE }
    rule(/-/) { :NEGATION }
  end
end
