require "spec_helper"
require "yuriita/filters/custom_condition"
require "yuriita/query/input"

RSpec.describe Yuriita::Filters::CustomCondition do
  describe "#apply" do
    it "matches any qualifier" do
      filter = described_class.new(qualifiers: ["author"]) do |value|
        { joined: { key: value } }
      end
      input = Yuriita::Query::Input.new(qualifier: "author", term: "eebs")

      result = filter.apply(input)

      expect(result).to eq Yuriita::Clauses::Where.new(joined: { key: "eebs" })
    end

    it "returns a WhereNot if the input is negative" do
      filter = described_class.new(qualifiers: ["author"]) do |value|
        { joined: { key: value } }
      end
      input = Yuriita::Query::Input.new(
        qualifier: "author",
        term: "eebs",
        negated: true,
      )

      result = filter.apply(input)

      expect(result).to eq Yuriita::Clauses::WhereNot.new(joined: { key: "eebs" })
    end

    it "returns a no-op if it does not match the input" do
      filter = described_class.new(qualifiers: ["author"]) do |value|
        { joined: { key: value } }
      end
      input = Yuriita::Query::Input.new(
        qualifier: "is",
        term: "open",
        negated: true,
      )

      result = filter.apply(input)

      expect(result).to eq Yuriita::Clauses::Noop.new
    end
  end
end
