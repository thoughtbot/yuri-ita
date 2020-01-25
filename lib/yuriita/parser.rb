require "rltk/parser"
require "yuriita/qualifier"

module Yuriita
  class Parser < RLTK::Parser
    production(:query) do
      clause("SPACE? .expressions SPACE?") { |e| e }
    end

    production(:expressions) do
      clause(".expression") { |e| [e] }
      clause(".expressions SPACE .expression") do |list, expression|
        list + [expression]
      end
    end

    production(:expression) do
      clause(".qualifier COLON .term") do |qualifier, term|
        if qualifier.negated?
          { key: qualifier.key, value: term, negated: true }
        else
          { key: qualifier.key, value: term }
        end
      end
    end

    production(:qualifier) do
      clause(:WORD) { |word| Qualifier.new(key: word, negated: false) }
      clause("NEGATION .WORD") { |word| Qualifier.new(key: word, negated: true) }
    end

    production(:term) do
      clause(:WORD) { |w| w }
      clause("QUOTE SPACE? .phrase SPACE? QUOTE") { |phrase| phrase.join(" ") }
    end

    production(:phrase) do
      clause(:WORD) { |w| [w] }
      clause(".phrase SPACE .WORD") { |phrase, word| phrase + [word] }
    end

    finalize
  end
end
