RSpec.describe Yuriita::Selects::Single do
  describe "filter" do
    context "when there are no selected options" do
      it "returns the selected option's filter" do
        active_input = build(:expression, qualifier: "is", term: "active")
        active_filter = build(:expression_filter, input: active_input)
        active_option = build(:option, name: "Active", filter: active_filter)
        hidden_input = build(:expression, qualifier: "is", term: "hidden")
        hidden_filter = build(:expression_filter, input: hidden_input)
        hidden_option = build(:option, name: "Hidden", filter: hidden_filter)

        query = build(
          :query,
          inputs: [build(:expression, qualifier: "author", term: "eebs")],
        )

        selector = described_class.new(
          options: [active_option, hidden_option],
          query:,
        )

        expect(selector.filter).to be nil
      end
    end

    context "when there is a selected option" do
      it "returns the selected option's filter" do
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
          query:,
        )

        expect(selector.filter).to eq active_filter
      end
    end
  end

  describe "#selected?" do
    context "when the there are no inputs" do
      it "the option is not selected" do
        active_option = build_option("Active", "is", "active")
        hidden_option = build_option("Hidden", "is", "hidden")

        query = build(:query, inputs: [])

        selector = described_class.new(
          options: [active_option, hidden_option],
          query:,
        )

        result = selector.selected?(active_option)

        expect(result).to be false
      end
    end

    context "when the option's input is in the query" do
      it "the option is selected" do
        active_option = build_option("Active", "is", "active")
        hidden_option = build_option("Hidden", "is", "hidden")

        query = build(
          :query,
          inputs: [build(:expression, qualifier: "is", term: "active")],
        )

        selector = described_class.new(
          options: [active_option, hidden_option],
          query:,
        )

        result = selector.selected?(active_option)

        expect(result).to be true
      end
    end

    context "when multiple matching inputs are present" do
      it "the option matching the last matched input is selected" do
        active_option = build_option("Active", "is", "active")
        hidden_option = build_option("Hidden", "is", "hidden")

        query = build(
          :query,
          inputs: [
            build(:expression, qualifier: "is", term: "hidden"),
            build(:expression, qualifier: "is", term: "active"),
          ],
        )

        selector = described_class.new(
          options: [active_option, hidden_option],
          query:,
        )

        active_selected = selector.selected?(active_option)
        hidden_selected = selector.selected?(hidden_option)

        expect(active_selected).to be true
        expect(hidden_selected).to be false
      end
    end
  end

  def build_option(name, qualifier, term)
    input = build(:expression, qualifier:, term:)
    build(:option, name:, filter: build(:expression_filter, input:))
  end
end
