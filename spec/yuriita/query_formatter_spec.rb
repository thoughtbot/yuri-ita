RSpec.describe Yuriita::QueryFormatter do
  describe "#format" do
    it "returns a an ordered input string keyed by the param_key" do
      string = "cats in:title is:published"
      query =Yuriita::QueryBuilder.build(string)

      formatted = described_class.new(param_key: :q).format(query)

      expect(formatted).to eq({ q: "cats in:title is:published" })
    end

    it "returns an empty string when the query is empty" do
      query = Yuriita::Query.new

      formatted = described_class.new(param_key: :q).format(query)

      expect(formatted).to eq({ q: "" })
    end
  end
end
