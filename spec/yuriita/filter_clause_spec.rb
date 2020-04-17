require "rails_helper"

RSpec.describe Yuriita::FilterClause do
  describe "#apply" do
    it "returns the relation when there are no filters" do
      filters = []
      combination = Yuriita::AndCombination
      relation = double(:relation)

      clause = described_class.new(filters: filters, combination: combination)
      result = clause.apply(relation)

      expect(result).to eq(relation)
    end

    it "combines the applied filters using the combination" do
      published = create(:post, :published)
      draft = create(:post, :draft)
      published_filter = build(
        :expression_filter,
        block: ->(relation) { relation.published },
      )
      draft_filter = build(
        :expression_filter,
        block: ->(relation) { relation.draft },
      )
      filters = [published_filter, draft_filter]

      clause = described_class.new(
        filters: filters,
        combination: Yuriita::OrCombination,
      )
      result = clause.apply(Post.all)

      expect(result).to contain_exactly(published, draft)
    end
  end
end
