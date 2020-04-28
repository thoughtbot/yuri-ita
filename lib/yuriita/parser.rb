require "rltk/parser"

module Yuriita
  class Parser < RLTK::Parser
    left :SPACE

    production(:query) do
      clause("SPACE? .input_list SPACE?") do |inputs|
        Query.new(inputs: inputs)
      end
      clause("SPACE?") { |_| Query.new }
    end

    production(:input_list) do
      clause(".input") { |input| [input] }
      clause(".input_list SPACE .input") { |head, tail| head + [tail] }
    end

    production(:input) do
      clause(".keyword") { |keyword| keyword }
      clause(".search_input") { |search_input| search_input }
      clause(".expression_input") { |expression_input| expression_input }
      clause(".sort_input") { |sort_input| sort_input }
    end

    production(:keyword) do
      clause(:WORD) { |word| word }
      clause("QUOTE SPACE? .phrase SPACE? QUOTE") { |phrase| phrase.join(" ") }
    end

    production(:expression_input) do
      clause(".qualifier COLON .term") do |qualifier, term|
        Query::Input.new(qualifier: qualifier, term: term)
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
