require "rails_helper"
require "yuriita/matchers/term"

RSpec.describe "sorting" do
  it "sorts results" do
    cat_post = create(:post, title: "Cats are great")
    elephant_post = create(:post, title: "Whoa. Elephants.")
    duck_post = create(:post, title: "Ducks are okay too")
    title_sort= Yuriita::Sorter.new(matcher: term_matcher("title")) do
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

  def term_matcher(term)
    Yuriita::Matchers::Term.new(term: term)
  end
end
