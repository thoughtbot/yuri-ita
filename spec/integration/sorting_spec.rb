require "rails_helper"

RSpec.describe "sorting" do
  it "sorts results" do
    cat_post = create(:post, title: "Cats are great")
    elephant_post = create(:post, title: "Whoa. Elephants.")
    duck_post = create(:post, title: "Ducks are okay too")

    result = Yuriita.filter(
      Post.all,
      "sort:title-asc",
      PostDefinition.build,
    )
  end
end
