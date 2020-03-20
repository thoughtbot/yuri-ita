require "spec_helper"
require "yuriita/assembler"
require "yuriita/query/definition"

RSpec.describe Yuriita::Assembler do
  describe "#build" do
    it "apples the expression_inputs to each filter" do
      inputs = [ double(:expression_input) ]
      query = double(:query, inputs: inputs, keywords: [])
      first_result = double(:result)
      second_result = double(:result)
      first_filter = double(:filter, apply: first_result)
      second_filter = double(:filter, apply: second_result)
      definition = Yuriita::Query::Definition.new(
        expression_filters: [first_filter, second_filter],
      )
      result = described_class.new(definition).build(query)

      expect(result).to eq [first_result, second_result]
      expect(first_filter).to have_received(:apply).with(inputs)
      expect(second_filter).to have_received(:apply).with(inputs)
    end
  end
end
