require "rails_helper"

RSpec.describe "combining expressions, search, and sort" do
  it "returns keyword results, expression results, and sorted results" do
    cat_post = create(:post, title: "Cats are great", published: false)
    elephant_post = create(:post, title: "Elephants are great", published: true)
    duck_post = create(:post, title: "Ducks are great, too", published: true)
    frog_post = create(:post, title: "Frogs are just ok", published: true)

    result = Yuriita.filter(
      Post.all,
      "sort:title-asc is:published great",
      PostDefinition.build
    )

    expect(result.relation).to eq([duck_post, elephant_post])
  end
end
