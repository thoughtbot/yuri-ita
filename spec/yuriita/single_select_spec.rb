RSpec.describe Yuriita::SingleSelect do
  describe "filter" do
    context "when there are no selected options" do
      it "returns the selected option's filter" do
        active_input = build(:input, qualifier: "is", term: "active")
        active_filter = build(:expression_filter, input: active_input)
        active_option = build(:option, name: "Active", filter: active_filter)
        hidden_input = build(:input, qualifier: "is", term: "hidden")
        hidden_filter = build(:expression_filter, input: hidden_input)
        hidden_option = build(:option, name: "Hidden", filter: hidden_filter)

        query = build(
          :query,
          inputs: [build(:input, qualifier: "author", term: "eebs")],
        )

        selector = described_class.new(
          options: [active_option, hidden_option],
          query: query,
        )

        expect(selector.filter).to be nil
      end
    end

    context "when there is a selected option" do
      it "returns the selected option's filter" do
        active_input = build(:input, qualifier: "is", term: "active")
        active_filter = build(:expression_filter, input: active_input)
        active_option = build(:option, name: "Active", filter: active_filter)
        hidden_input = build(:input, qualifier: "is", term: "hidden")
        hidden_filter = build(:expression_filter, input: hidden_input)
        hidden_option = build(:option, name: "Hidden", filter: hidden_filter)

        query = build(
          :query,
          inputs: [build(:input, qualifier: "is", term: "active")],
        )

        selector = described_class.new(
          options: [active_option, hidden_option],
          query: query,
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
          query: query,
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
          inputs: [build(:input, qualifier: "is", term: "active")],
        )

        selector = described_class.new(
          options: [active_option, hidden_option],
          query: query,
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
            build(:input, qualifier: "is", term: "hidden"),
            build(:input, qualifier: "is", term: "active"),
          ],
        )

        selector = described_class.new(
          options: [active_option, hidden_option],
          query: query,
        )
        active_selected = selector.selected?(active_option)
        hidden_selected = selector.selected?(hidden_option)

        expect(active_selected).to be true
        expect(hidden_selected).to be false
      end
    end
  end

  describe "#empty?" do
    it "returns true when none of the options match the query" do
      active_option = build_option("Active", "is", "active")
      hidden_option = build_option("Hidden", "is", "hidden")
      query = build(
        :query,
        inputs: [build(:input, qualifier: "author", term: "eebs")],
      )

      selector = described_class.new(
        options: [active_option, hidden_option],
        query: query,
      )

      expect(selector).to be_empty
    end
  end

  def build_option(name, qualifier, term)
    input = build(:input, qualifier: qualifier, term: term)
    build(:option, name: name, filter: build(:expression_filter, input: input))
  end
end
