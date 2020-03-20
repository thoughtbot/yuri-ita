RSpec.describe Yuriita::Query do
  describe "#keywords" do
    it "returns the initialized keywords" do
      keywords = double(:keywords)
      query = described_class.new(keywords: keywords)

      expect(query.keywords).to eq keywords
    end
  end

  describe "#inputs" do
    it "returns the initialized" do
      inputs = double(:inputs)
      query = described_class.new(inputs: inputs)

      expect(query.inputs).to eq inputs
    end
  end
end
