require "rails_helper"
require "yuriita/or_combination"
require "yuriita/and_combination"
require "yuriita/matchers/qualifier"
require "yuriita/matchers/expression"

RSpec.describe "filtering by expression" do
  it "returns results matching an expression" do
    published = create(:post, published: true)
    not_published = create(:post, published: false)
    filter = and_filter(expression_macther("is", "published")) do
      { published: true }
    end
    definition = build_definition(filters: [filter])

    result = Yuriita.filter(
      Post.all,
      "is:published",
      definition: definition,
    )

    expect(result.relation).to contain_exactly(published)
  end

  it "returns results matching one or more expressions" do
    cat_category = create(:category, name: "cats")
    pig_category = create(:category, name: "pigs")
    duck_category = create(:category, name: "ducks")
    cat_post = create(:post, categories: [cat_category])
    pig_post = create(:post, categories: [pig_category])
    duck_post = create(:post, categories: [duck_category])
    filter = or_filter(qualifier_matcher("category")) do |value|
      { categories: { name: value } }
    end
    definition = build_definition(filters: [filter])

    result = Yuriita.filter(
      Post.all.joins(:categories),
      "category:cats category:ducks",
      definition: definition,
    )

    expect(result.relation).to contain_exactly(cat_post, duck_post)
  end

  def build_definition(filters:)
    Yuriita::Query::Definition.new(filters: filters)
  end

  def qualifier_matcher(qualifier)
    Yuriita::Matchers::Qualifier.new(qualifier: qualifier)
  end

  def expression_macther(qualifier, term)
    Yuriita::Matchers::Expression.new(qualifier: qualifier, term: term)
  end

  def and_filter(*matchers, &block)
    Yuriita::ExpressionFilter.new(
      matchers: matchers,
      combination: Yuriita::AndCombination,
      &block
    )
  end

  def or_filter(*matchers, &block)
    Yuriita::ExpressionFilter.new(
      matchers: matchers,
      combination: Yuriita::OrCombination,
      &block
    )
  end
end
