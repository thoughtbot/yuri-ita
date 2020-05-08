RSpec.describe Yuriita::Selects::Multiple do
  describe "filters" do
    it "returns the selected option's filters" do
      active_input = build(:expression, qualifier: "is", term: "active")
      active_filter = build(:expression_filter, input: active_input)
      active_option = build(:option, name: "Active", filter: active_filter)
      hidden_input = build(:expression, qualifier: "is", term: "hidden")
      hidden_filter = build(:expression_filter, input: hidden_input)
      hidden_option = build(:option, name: "Hidden", filter: hidden_filter)

      query = build(
        :query,
        inputs: [build(:expression, qualifier: "is", term: "active")],
      )

      selector = described_class.new(
        options: [active_option, hidden_option],
        query: query,
      )

      expect(selector.filters).to eq [active_filter]
    end
  end

  describe "#selected?" do
    it "returns true if the given option's input is in the query" do
      active_option = build_option("Active", "is", "active")
      hidden_option = build_option("Hidden", "is", "hidden")
      query = build(
        :query,
        inputs: [build(:expression, qualifier: "is", term: "active")],
      )

      selector = described_class.new(
        options: [active_option, hidden_option],
        query: query,
      )
      result = selector.selected?(active_option)

      expect(result).to be true
    end

    it "returns false if the given option's input is not in the query" do
      active_option = build_option("Active", "is", "active")
      hidden_option = build_option("Hidden", "is", "hidden")
      query = build(
        :query,
        inputs: [build(:expression, qualifier: "is", term: "active")],
      )

      selector = described_class.new(
        options: [active_option, hidden_option],
        query: query,
      )
      result = selector.selected?(hidden_option)

      expect(result).to be false
    end
  end

  def build_option(name, qualifier, term)
    expression = build(:expression, qualifier: qualifier, term: term)
    build(
      :option,
      name: name,
      filter: build(:expression_filter, input: expression),
    )
  end
end
