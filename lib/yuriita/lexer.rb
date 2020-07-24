require "rltk/lexer"

module Yuriita
  class Lexer < RLTK::Lexer
    rule(/[ \t\f]+/) { :SPACE }
    rule(/:/) { :COLON }
    rule(/[^ \t\f:"]+/) { |t| [:WORD, t] }
    rule(/"/) { :QUOTE }
  end
end
