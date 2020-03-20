require "rails_helper"
require "yuriita/matchers/term"

RSpec.describe "searching by keyword" do
  it "returns results including the keyword" do
    cat_post = create(:post, title: "Cats are great")
    duck_post = create(:post, title: "Ducks are okay too")
    title_search = and_search(term_matcher("title")) do |value|
      ["title ILIKE :value", value: "%#{value}%"]
    end
    definition = Yuriita::Query::Definition.new(keyword_filters: [title_search])

    result = Yuriita.filter(
      Post.all,
      "cats",
      definition,
    )

    expect(result.relation).to contain_exactly(cat_post)
  end

  it "returns results with all keywords when no scope inputs are given" do
    cat_post = create(:post, title: "Cats", body: "Cats are not pigs")
    pig_post = create(:post, title: "Pigs are not cats", body: "Pigs")
    pig_title_post = create(:post, title: "Pigs")

    title_search = and_search(term_matcher("title")) do |value|
      ["title ILIKE :value", value: "%#{value}%"]
    end
    body_search = and_search(term_matcher("body")) do |value|
      ["body ILIKE :value", value: "%#{value}%"]
    end
    description_search = and_search(term_matcher("description")) do |value|
      ["description ILIKE :value", value: "%#{value}%"]
    end
    definition = Yuriita::Query::Definition.new(
      keyword_filters: [title_search, body_search, description_search],
    )

    result = Yuriita.filter(
      Post.all,
      "cats pigs",
      definition,
    )

    expect(result.relation).to contain_exactly(cat_post, pig_post)
  end

  it "returns results with all keywords in any of the given scope inputs" do
    cat_post = create(:post, title: "Cats", body: "Cats are not pigs")
    pig_post = create(:post, title: "Pigs are not cats", body: "Pigs")
    pig_title_post = create(:post, title: "Pigs")
    description_post = create(:post, description: "cats and pigs")

    title_search = and_search(term_matcher("title")) do |value|
      ["title ILIKE :value", value: "%#{value}%"]
    end
    body_search = and_search(term_matcher("body")) do |value|
      ["body ILIKE :value", value: "%#{value}%"]
    end
    description_search = and_search(term_matcher("description")) do |value|
      ["description ILIKE :value", value: "%#{value}%"]
    end
    definition = Yuriita::Query::Definition.new(
      keyword_filters: [title_search, body_search, description_search],
    )

    result = Yuriita.filter(
      Post.all,
      "cats pigs in:title in:body",
      definition,
    )

    expect(result.relation).to contain_exactly(cat_post, pig_post)
  end

  def term_matcher(term)
    Yuriita::Matchers::Term.new(term: term)
  end

  def and_search(*matchers, &block)
    Yuriita::KeywordFilter.new(
      matchers: matchers,
      combination: Yuriita::AndCombination,
      &block
    )
  end
end
