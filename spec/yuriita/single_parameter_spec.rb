RSpec.describe Yuriita::SingleParameter do
  describe "#select" do
    it "replaces existing inputs in the query with the new input" do
      active_input = build(:input, qualifier: "is", term: "active")
      active_filter = build(:expression_filter, input: active_input)
      active_option = build(:option, name: "Active", filter: active_filter)
      hidden_input = build(:input, qualifier: "is", term: "hidden")
      hidden_filter = build(:expression_filter, input: hidden_input)
      hidden_option = build(:option, name: "Hidden", filter: hidden_filter)
      query = Yuriita::Query.new(inputs: [active_input])

      formatter = Yuriita::QueryFormatter.new(param_key: :q)
      parameters = described_class.new(
        options: [active_option, hidden_option],
        query: query,
        formatter: formatter,
      )
      result = parameters.select(hidden_input)

      expect(result).to eq({ q: "is:hidden" })
    end
  end

  describe "#deselect" do
    it "removes all existing inputs from the query" do
      active_input = build(:input, qualifier: "is", term: "active")
      active_filter = build(:expression_filter, input: active_input)
      active_option = build(:option, name: "Active", filter: active_filter)
      hidden_input = build(:input, qualifier: "is", term: "hidden")
      hidden_filter = build(:expression_filter, input: hidden_input)
      hidden_option = build(:option, name: "Hidden", filter: hidden_filter)
      query = Yuriita::Query.new(inputs: [active_input, hidden_input])

      formatter = Yuriita::QueryFormatter.new(param_key: :q)
      parameters = described_class.new(
        options: [active_option, hidden_option],
        query: query,
        formatter: formatter,
      )
      result = parameters.deselect(hidden_input)

      expect(result).to eq({ q: "" })
    end
  end
end
