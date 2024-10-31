require "rails_helper"

RSpec.describe "filtering by expression" do
  it "returns results matching an expression" do
    published = create(:post, published: true)
    create(:post, published: false)

    result = Yuriita.filter(
      Post.all,
      "is:published",
      PostDefinition.build
    )

    expect(result.relation).to contain_exactly(published)
  end

  it "returns results matching one or more expressions" do
    cat_category = create(:category, name: "cats")
    pig_category = create(:category, name: "pigs")
    duck_category = create(:category, name: "ducks")
    cat_post = create(:post, categories: [cat_category])
    create(:post, categories: [pig_category])
    duck_post = create(:post, categories: [duck_category])

    result = Yuriita.filter(
      Post.all,
      "category:cats category:ducks",
      PostDefinition.build
    )

    expect(result.relation).to contain_exactly(cat_post, duck_post)
  end
end
