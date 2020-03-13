require "rltk/parser"
require "yuriita/query"
require "yuriita/query/fragment"
require "yuriita/query/input"

module Yuriita
  class Parser < RLTK::Parser
    left :SPACE

    production(:query) do
      clause("SPACE? .fragment SPACE?") do |fragment|
        Query.new(
          keywords: fragment.keywords,
          expression_inputs: fragment.expression_inputs,
          scope_inputs: fragment.scope_inputs,
          sort_inputs: fragment.sort_inputs,
        )
      end
    end

    production(:fragment) do
      clause(".keyword") do |keyword|
        Query::Fragment.new(keywords: [keyword])
      end
      clause(".scope_input") do |scope_input|
        Query::Fragment.new(scope_inputs: [scope_input])
      end
      clause(".expression_input") do |expression_input|
        Query::Fragment.new(expression_inputs: [expression_input])
      end
      clause(".sort_input") do |sort_input|
        Query::Fragment.new(sort_inputs: [sort_input])
      end
      clause(".fragment SPACE .fragment") do |head, tail|
        head.merge(tail)
      end
    end

    production(:keyword) do
      clause(:WORD) { |word| word }
    end

    production(:expression_input) do
      clause(".qualifier COLON .term") do |qualifier, term|
        Query::Input.new(qualifier: qualifier, term: term)
      end
      clause("NEGATION .qualifier COLON .term") do |qualifier, term|
        Query::Input.new(qualifier: qualifier, term: term, negated: true)
      end
    end

    production(:scope_input) do
      clause("IN COLON .scope") do |scope|
        Query::Input.new(qualifier: "in", term: scope)
      end
    end

    production(:sort_input) do
      clause("SORT COLON .order") do |order|
        Query::Input.new(qualifier: "sort", term: order)
      end
    end

    production(:scope) do
      clause(:WORD) { |word| word }
    end

    production(:qualifier) do
      clause(:WORD) { |word| word }
    end

    production(:order) do
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
