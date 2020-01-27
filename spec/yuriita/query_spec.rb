require "spec_helper"

RSpec.describe Yuriita::Query do
  describe "#keywords" do
    it "returns the initialized keywords" do
      keywords = double(:keywords)
      query = described_class.new(keywords: keywords)

      expect(query.keywords).to eq keywords
    end
  end

  describe "#expressions" do
    it "returns the initialized expressions" do
      expressions = double(:expressions)
      query = described_class.new(expressions: expressions)

      expect(query.expressions).to eq expressions
    end
  end
end
