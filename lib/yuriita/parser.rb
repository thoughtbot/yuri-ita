require "rltk/parser"
require "yuriita/expression"

module Yuriita
  class Parser < RLTK::Parser
    production(:query) do
      clause("SPACE? .expressions SPACE?") do |expressions|
        Query.new(expressions)
      end
    end

    production(:expressions) do
      clause("expression") { |expression| [expression] }
      clause(".expressions SPACE .expression") do |list, expression|
        list + [expression]
      end
    end

    production(:expression) do
      clause(".qualifier COLON .term") do |qualifier, term|
        Expression.new(qualifier: qualifier, term: term)
      end
      clause("NEGATION .qualifier COLON .term") do |qualifier, term|
        NegatedExpression.new(qualifier: qualifier, term: term)
      end
    end

    production(:qualifier) do
      clause(:WORD) { |word| word }
    end

    production(:term) do
      clause(:WORD) { |word| word }
      clause("QUOTE SPACE? .phrase SPACE? QUOTE") { |phrase| phrase.join(" ") }
    end

    production(:phrase) do
      clause(:WORD) { |word| [word] }
      clause(".phrase SPACE .WORD") { |phrase, word| phrase + [word] }
    end

    finalize
  end
end
