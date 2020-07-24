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
      clause(".expression") { |expression| expression }
    end

    production(:keyword) do
      clause(:WORD) { |word| Inputs::Keyword.new(word) }
      clause("QUOTE SPACE? .phrase SPACE? QUOTE") do |phrase|
        Inputs::Keyword.new(phrase)
      end
    end

    production(:expression) do
      clause(".qualifier COLON .term") do |qualifier, term|
        Inputs::Expression.new(qualifier, term)
      end
    end

    production(:scope_field) do
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
      clause("QUOTE SPACE? .phrase SPACE? QUOTE") { |phrase| phrase }
    end

    production(:phrase) do
      clause(:WORD) { |word| word }
      clause(".phrase SPACE .WORD") { |phrase, word| phrase + " " + word }
    end

    finalize
  end
end
