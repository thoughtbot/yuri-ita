require "rails_helper"

RSpec.describe "searching by keyword" do
  it "returns results including the keyword" do
    cat_post = create(:post, title: "Cats are great")
    duck_post = create(:post, title: "Ducks are okay too")

    result = Yuriita.filter(
      Post.all,
      "cats",
      PostDefinition.build,
    )

    expect(result.relation).to contain_exactly(cat_post)
  end

  it "returns results with all keywords when no scope inputs are given" do
    cat_post = create(:post, title: "Cats", body: "Cats are not pigs")
    pig_post = create(:post, title: "Pigs are not cats", body: "Pigs")
    pig_title_post = create(:post, title: "Pigs")

    result = Yuriita.filter(
      Post.all,
      "cats pigs",
      PostDefinition.build,
    )

    expect(result.relation).to contain_exactly(cat_post, pig_post)
  end

  it "returns results with all keywords in any of the given scope inputs" do
    cat_post = create(:post, title: "Cats", body: "Cats are not pigs")
    pig_post = create(:post, title: "Pigs are not cats", body: "Pigs")
    pig_title_post = create(:post, title: "Pigs")
    description_post = create(:post, description: "cats and pigs")

    result = Yuriita.filter(
      Post.all,
      "cats pigs in:title in:body",
      PostDefinition.build,
    )

    expect(result.relation).to contain_exactly(cat_post, pig_post)
  end

  it "does nothing when only a scope is provided" do
    cat_post = create(:post, title: "Cats", body: "Cats are not pigs")
    pig_post = create(:post, title: "Pigs are not cats", body: "Pigs")

    result = Yuriita.filter(
      Post.all,
      "in:title",
      PostDefinition.build,
    )

    expect(result.relation).to contain_exactly(cat_post, pig_post)
  end
end
