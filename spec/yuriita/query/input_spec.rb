require "yuriita/query/input"

RSpec.describe Yuriita::Query::Input do
  describe "negated?" do
    it "is false by default" do
      input = described_class.new(qualifier: "is", term: "active")

      expect(input).not_to be_negated
    end

    it "can be set to true" do
      input = described_class.new(
        qualifier:
        "is",
        term: "active",
        negated: true,
      )

      expect(input).to be_negated
    end
  end

  describe "#qualifier" do
    it "returns the provided qualifier" do
      input = described_class.new(qualifier: "is", term: "active")

      expect(input.qualifier).to eq "is"
    end
  end

  describe "#term" do
    it "returns the provided term" do
      input = described_class.new(qualifier: "is", term: "active")

      expect(input.term).to eq "active"
    end
  end
end
