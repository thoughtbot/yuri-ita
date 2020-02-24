require "spec_helper"
require "yuriita/assembler"
require "yuriita/query/definition"

RSpec.describe Yuriita::Assembler do
  describe "#build" do
    it "apples the expressions to each filter" do
      expressions = [ double(:expression) ]
      query = double(:query, expressions: expressions, keywords: [], scopes: [])
      first_result = double(:result)
      second_result = double(:result)
      first_filter = double(:filter, apply: first_result)
      second_filter = double(:filter, apply: second_result)
      definition = Yuriita::Query::Definition.new(
        filters: [first_filter, second_filter],
      )
      result = described_class.new(definition).build(query)

      expect(result).to eq [first_result, second_result]
      expect(first_filter).to have_received(:apply).with(expressions)
      expect(second_filter).to have_received(:apply).with(expressions)
    end
  end
end
