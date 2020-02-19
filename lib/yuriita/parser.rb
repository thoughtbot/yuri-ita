require "rltk/parser"
require "yuriita/fragment"
require "yuriita/query"
require "yuriita/query/input"

module Yuriita
  class Parser < RLTK::Parser
    left :SPACE

    production(:query) do
      clause("SPACE? .fragment SPACE?") do |fragment|
        Query.new(
          keywords: fragment.keywords,
          expressions: fragment.expressions,
          scopes: fragment.scopes,
        )
      end
    end

    production(:fragment) do
      clause(".keyword") do |keyword|
        Fragment.new(keywords: [keyword])
      end
      clause(".keyword_scope") do |scope|
        Fragment.new(scopes: [scope])
      end
      clause(".expression") do |expression|
        Fragment.new(expressions: [expression])
      end
      clause(".fragment SPACE .fragment") do |head, tail|
        head.merge(tail)
      end
    end

    production(:keyword) do
      clause(:WORD) { |word| word }
    end

    production(:expression) do
      clause(".qualifier COLON .term") do |qualifier, term|
        Query::Input.new(qualifier: qualifier, term: term)
      end
      clause("NEGATION .qualifier COLON .term") do |qualifier, term|
        Query::Input.new(qualifier: qualifier, term: term, negated: true)
      end
    end

    production(:keyword_scope) do
      clause("IN COLON .scope") do |scope|
        Query::Input.new(qualifier: "in", term: scope)
      end
    end

    production(:scope) do
      clause(:WORD) { |word| word }
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
