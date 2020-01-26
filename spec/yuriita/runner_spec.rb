require "spec_helper"
require "yuriita/runner"

RSpec.describe Yuriita::Runner do
  describe "#run" do
    it "parses and executes the query" do
      filtered_result = double(:filtered_result, successful?: true)
      executor = double(:executor, run: filtered_result)
      query = double(:query, apply: executor)
      parser = double(:parser, parse: query)
      lexer = double(:lexer, lex: tokens)
      relation = double(:relation)
      definition = double(:definition)

      input = "is:active"
      runner = described_class.new(
        relation: relation,
        definition: definition,
        lexer: lexer,
        parser: parser,
      )
      result = runner.run(input)

      expect(result).to be_successful
      expect(lexer).to have_received(:lex).with(input)
      expect(parser).to have_received(:parse).with(tokens)
      expect(executor).to have_received(:run).with(relation)
    end

    it "returns an error result for invalid queries" do

    end
  end
end
