require "rltk/lexer"

module Yuriita
  class Lexer < RLTK::Lexer
    DATETIME_REGEX = %r{
      ([0-9]{4})-(1[0-2]|0[1-9])-(3[01]|0[1-9]|[12][0-9])
      (
        T
        ((2[0-3]|[01][0-9]):([0-5][0-9]):([0-5][0-9]))
        (Z|[+-](2[0-3]|[01][0-9])(:[0-5][0-9])?)
      )?
    }x

    rule(/[ \t\f]+/) { :SPACE }
    rule(/:/) { :COLON }
    rule(/>/) { :GT }
    rule(DATETIME_REGEX) { |d| [:DATETIME, DateTime.parse(d)] }
    rule(/[^ >\t\f:"]+/) { |t| [:WORD, t] }
    rule(/"/) { :QUOTE }
  end
end
