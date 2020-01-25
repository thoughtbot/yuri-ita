require "rltk/parser"

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
      clause(".qualifier COLON .term") { |key, value| {key: key, value: value} }
    end

    production(:qualifier) do
      clause(:WORD) { |w| w }
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
