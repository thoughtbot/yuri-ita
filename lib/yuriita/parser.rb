require "rltk/parser"
require "yuriita/expression"
require "yuriita/fragment"
require "yuriita/query"

module Yuriita
  class Parser < RLTK::Parser
    production(:query) do
      clause("SPACE? .fragment SPACE?") do |fragment|
        Query.new(
          keywords: fragment.keywords,
          expressions: fragment.expressions,
        )
      end
    end

    production(:fragment) do
      clause(".keywords") do |keywords|
        Fragment.new(keywords: keywords)
      end
      clause(".expressions") do |expressions|
        Fragment.new(expressions: expressions)
      end
      clause(".fragment SPACE .fragment") do |head, tail|
        head.merge(tail)
      end
    end

    production(:keywords) do
      clause(:keyword) { |keyword| [keyword] }
      clause(".keywords SPACE .keyword") do |list, keyword|
        list + [keyword]
      end
    end

    production(:keyword) do
      clause(:WORD) { |word| word }
    end

    production(:expressions) do
      clause(:expression) { |expression| [expression] }
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
