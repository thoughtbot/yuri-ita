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
          inputs: fragment.inputs,
        )
      end
    end

    production(:fragment) do
      clause(".keyword") do |keyword|
        Query::Fragment.new(keywords: [keyword])
      end
      clause(".search_input") do |search_input|
        Query::Fragment.new(inputs: [search_input])
      end
      clause(".expression_input") do |expression_input|
        Query::Fragment.new(inputs: [expression_input])
      end
      clause(".sort_input") do |sort_input|
        Query::Fragment.new(inputs: [sort_input])
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

    production(:search_input) do
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
