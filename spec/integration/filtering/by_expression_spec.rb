require "rails_helper"

RSpec.describe "filtering by expression" do
  it "returns results matching an expression" do
    published = create(:post, published: true)
    not_published = create(:post, published: false)
    definition = build_definition

    result = Yuriita.filter(
      Post.all,
      "is:published",
      query_definition: definition,
    )

    expect(result.relation).to contain_exactly(published)
  end

  def build_definition
    Yuriita::QueryDefinition.new(
      filters: [
        Yuriita::Filters::FixedCondition.new(
          expressions: [ Yuriita::Definition::Expression.new("is:published") ],
          conditions: { published: true },
        )
      ]
    )
  end
end
