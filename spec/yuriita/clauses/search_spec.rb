require "rails_helper"

RSpec.describe Yuriita::Clauses::Search do
  describe "#apply" do
    it "combines the applied filters using the combination" do
      cats_post = create(:post, title: "cats")
      ducks_post = create(:post, title: "ducks", description: "cats")

      title_filter = build(
        :search_filter,
        block: ->(relation, term) { relation.search(:title, term) },
      )

      description_filter = build(
        :search_filter,
        block: ->(relation, term) { relation.search(:description, term) },
      )

      filters = [title_filter, description_filter]
      keyword = build(:keyword, value: "cats")

      clause = described_class.new(
        filters:,
        keywords: [keyword],
        combination: Yuriita::OrCombination,
      )

      result = clause.apply(Post.all)

      expect(result).to contain_exactly(cats_post, ducks_post)
    end
  end
end
