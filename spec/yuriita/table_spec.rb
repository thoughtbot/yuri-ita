RSpec.describe Yuriita::Table do
  describe "#q" do
    it "returns the default input if none is given" do
      table = described_class.new(
        relation: double(:relation),
        configuration: double(:configuration, default_input: "is:published"),
        params: {},
      )

      expect(table.q).to eq "is:published "
    end

    it "returns the input when one is provided" do
      table = described_class.new(
        relation: double(:relation),
        configuration: double(:configuration, default_input: "is:published"),
        params: { q: "" },
      )

      expect(table.q).to eq ""
    end
  end

  describe "#filtered?" do
    it "is true when user input is not equal to the default input" do
      table = described_class.new(
        relation: double(:relation),
        configuration: double(:configuration, default_input: "is:published"),
        params: { q: "is:draft" },
      )

      expect(table.filtered?).to be true
    end

    it "is true when the user input is in a different order from the default" do
      table = described_class.new(
        relation: double(:relation),
        configuration: double(:configuration, default_input: "author:eebs is:draft"),
        params: { q: "is:draft author:eebs" },
      )

      expect(table.filtered?).to be true
    end

    it "is false when user input is equal to the default input" do
      table = described_class.new(
        relation: double(:relation),
        configuration: double(:configuration, default_input: "is:published"),
        params: { q: "is:published" },
      )

      expect(table.filtered?).to be false
    end

    it "is false with no user input" do
      table = described_class.new(
        relation: double(:relation),
        configuration: double(:configuration, default_input: "is:released"),
        params: {},
      )

      expect(table.filtered?).to be false
    end
  end
end
