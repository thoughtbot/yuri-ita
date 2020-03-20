RSpec.describe Yuriita::Query::Input do
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
