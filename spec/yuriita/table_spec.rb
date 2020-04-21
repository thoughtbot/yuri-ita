RSpec.describe Yuriita::Table do
  describe "#filtered?" do
    it "is true when user input is a non-empty string" do
      table = described_class.new(
        relation: double(:relation),
        configuration: double(:configuration),
        params: { q: "is:pubished" },
        param_key: :q,
      )

      expect(table.filtered?).to be true
    end

    it "is false when user input is an empty string" do
      table = described_class.new(
        relation: double(:relation),
        configuration: double(:configuration),
        params: { q: "" },
        param_key: :q,
      )

      expect(table.filtered?).to be false
    end

    it "is false with no user input" do
      table = described_class.new(
        relation: double(:relation),
        configuration: double(:configuration),
        params: {},
        param_key: :q,
      )

      expect(table.filtered?).to be false
    end
  end
end
