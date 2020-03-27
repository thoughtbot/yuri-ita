RSpec.describe Yuriita::QueryFormatter do
  describe "#format" do
    it "returns a an input string keyed by the param_key" do
      published = build(:input, qualifier: "is", term: "published")
      title = build(:input, qualifier: "in", term: "title")
      query = Yuriita::Query.new(inputs: [published, title], keywords: ["cats"])

      formatted = described_class.new(param_key: :q).format(query)

      expect(formatted).to eq({ q: "is:published in:title cats" })
    end

    it "returns an empty string when the query is empty" do
      query = Yuriita::Query.new

      formatted = described_class.new(param_key: :q).format(query)

      expect(formatted).to eq({ q: "" })
    end
  end
end
