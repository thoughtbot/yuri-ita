require "spec_helper"

RSpec.describe Yuriita::Query do
  describe "#keywords" do
    it "returns the initialized keywords" do
      keywords = double(:keywords)
      query = described_class.new(keywords: keywords)

      expect(query.keywords).to eq keywords
    end
  end

  describe "#expression_inputs" do
    it "returns the initialized expression_inputs" do
      expression_inputs = double(:expression_inputs)
      query = described_class.new(expression_inputs: expression_inputs)

      expect(query.expression_inputs).to eq expression_inputs
    end
  end
end
