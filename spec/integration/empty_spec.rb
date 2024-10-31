require "rails_helper"

RSpec.describe "an empty input string" do
  it "results in the original relation" do
    create_list(:post, 3)

    result = Yuriita.filter(
      Post.all,
      "",
      PostDefinition.build
    )

    expect(result.relation).to match_array(Post.all)
  end
end
