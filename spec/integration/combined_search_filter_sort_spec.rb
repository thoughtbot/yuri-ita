require "rails_helper"
require "yuriita/matchers/term"
require "yuriita/or_combination"
require "yuriita/and_combination"
require "yuriita/matchers/expression"

RSpec.describe "combining expressions, search, and sort" do
  it "returns keyword results, expression results, and sorted results" do
    cat_post = create(:post, title: "Cats are great", published: false)
    elephant_post = create(:post, title: "Elephants are great", published: true)
    duck_post = create(:post, title: "Ducks are great, too", published: true)
    frog_post = create(:post, title: "Frogs are just ok", published: true)

    title_search = and_search(term_matcher("title")) do |value|
      ["title ILIKE :value", value: "%#{value}%"]
    end
    title_sort= Yuriita::Sorter.new(matcher: term_matcher("title")) do
      { title: :asc }
    end
    published_filter = and_filter(expression_matcher("is", "published")) do
      { published: true }
    end

    definition = Yuriita::Query::Definition.new(keyword_filters: [title_search], sorters: [title_sort], expression_filters: [published_filter])

    result = Yuriita.filter(
      Post.all,
      "sort:title is:published great",
      definition,
    )

    expect(result.relation).to eq([duck_post, elephant_post])
  end

  def term_matcher(term)
    Yuriita::Matchers::Term.new(term: term)
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

  def and_search(matcher, &block)
    Yuriita::KeywordFilter.new(
      matcher: matcher,
      combination: Yuriita::AndCombination,
      &block
    )
  end
end
