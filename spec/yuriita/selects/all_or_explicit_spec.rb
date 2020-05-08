RSpec.describe Yuriita::Selects::AllOrExplicit do
  describe "filters" do
    context "when there are no selected options" do
      it "returns the all option's filters" do
        title_input = build(:scope, qualifier: "in", term: "title")
        title_filter = build(:search_filter, input: title_input)
        title_option = build(:option, name: "Title", filter: title_filter)
        tagline_input = build(:scope, qualifier: "in", term: "tagline")
        tagline_filter = build(:search_filter, input: tagline_input)
        tagline_option = build(:option, name: "Tagline", filter: tagline_filter)

        query = build(:query, inputs: [])

        selector = described_class.new(
          options: [title_option, tagline_option],
          query: query,
        )

        expect(selector.filters).to eq [title_filter, tagline_filter]
      end
    end

    context "when there is a selected option" do
      it "returns the selected options filters" do
        title_input = build(:scope, qualifier: "in", term: "title")
        title_filter = build(:search_filter, input: title_input)
        title_option = build(:option, name: "Title", filter: title_filter)
        tagline_input = build(:scope, qualifier: "in", term: "tagline")
        tagline_filter = build(:search_filter, input: tagline_input)
        tagline_option = build(:option, name: "Tagline", filter: tagline_filter)
        note_input = build(:scope, qualifier: "in", term: "note")
        note_filter = build(:search_filter, input: note_input)
        note_option = build(:option, name: "note", filter: note_filter)

        query = build(
          :query,
          inputs: [
            build(:scope, qualifier: "in", term: "title"),
            build(:scope, qualifier: "in", term: "note"),
          ],
        )

        selector = described_class.new(
          options: [title_option, tagline_option, note_option],
          query: query,
        )

        expect(selector.filters).to eq [title_filter, note_filter]
      end
    end
  end

  def build_option(name, qualifier, term)
    input = build(:scope, qualifier: qualifier, term: term)
    build(:option, name: name, filter: build(:search_filter, input: input))
  end
end
