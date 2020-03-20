require "rails_helper"
require "yuriita/or_combination"
require "yuriita/and_combination"
require "yuriita/matchers/expression"

RSpec.describe "filtering by expression" do
  it "returns results matching an expression" do
    published = create(:post, published: true)
    not_published = create(:post, published: false)
    expression_filter = and_filter(expression_matcher("is", "published")) do
      { published: true }
    end
    definition = build_definition(expression_filters: [expression_filter])

    result = Yuriita.filter(
      Post.all,
      "is:published",
      definition,
    )

    expect(result.relation).to contain_exactly(published)
  end

  def build_definition(expression_filters:)
    Yuriita::Query::Definition.new(expression_filters: expression_filters)
  end

  def expression_matcher(qualifier, term)
    Yuriita::Matchers::Expression.new(qualifier: qualifier, term: term)
  end

  def and_filter(matcher, &block)
    Yuriita::ExpressionFilter.new(
      matcher: matcher,
      combination: Yuriita::AndCombination,
      &block
    )
  end
end
