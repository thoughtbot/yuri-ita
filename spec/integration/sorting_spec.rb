require "rails_helper"

RSpec.describe "sorting" do
  it "sorts results" do
    cat_post = create(:post, title: "Cats are great")
    elephant_post = create(:post, title: "Whoa. Elephants.")
    duck_post = create(:post, title: "Ducks are okay too")
    title_sort= Yuriita::Sorter.new(matcher: expression_matcher("sort", "title")) do
      { title: :desc }
    end
    definition = Yuriita::Query::Definition.new(sorters: [title_sort])

    result = Yuriita.filter(
      Post.all,
      "sort:title",
      definition,
    )

    expect(result.relation).to eq([elephant_post, duck_post, cat_post])
  end

  def expression_matcher(qualifier, term)
    Yuriita::Matchers::Expression.new(qualifier: qualifier, term: term)
  end
end
