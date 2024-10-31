require "rails_helper"

RSpec.describe "sorting" do
  it "sorts results" do
    create(:post, title: "Cats are great")
    create(:post, title: "Whoa. Elephants.")
    create(:post, title: "Ducks are okay too")

    Yuriita.filter(
      Post.all,
      "sort:title-asc",
      PostDefinition.build
    )
  end
end
