RSpec.describe Yuriita::MultiParameter do
  describe "#select" do
    it "adds the input to the query" do
      active_input = build(:expression, qualifier: "is", term: "active")
      author_input = build(:expression, qualifier: "author", term: "eebs")
      query = Yuriita::Query.new(inputs: [active_input])

      formatter = Yuriita::QueryFormatter.new(param_key: :q)
      parameters = described_class.new(query: query, formatter: formatter)
      result = parameters.select(author_input)

      expect(result).to eq({ q: "is:active author:eebs" })
    end
  end

  describe "#deselect" do
    it "removes the input from the query" do
      active_input = build(:expression, qualifier: "is", term: "active")
      author_input = build(:expression, qualifier: "author", term: "eebs")
      query = Yuriita::Query.new(inputs: [active_input, author_input])

      formatter = Yuriita::QueryFormatter.new(param_key: :q)
      parameters = described_class.new(query: query, formatter: formatter)
      result = parameters.deselect(author_input)

      expect(result).to eq({ q: "is:active" })
    end
  end
end
