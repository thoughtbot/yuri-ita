require "rails_helper"

RSpec.describe "dynamic filtering" do
  it "returns results matching the input term" do
    eebs = create(:author, username: "eebs")
    sally = create(:author, username: "sally")
    eebs_post = create(:post, author: eebs)
    sally_post = create(:post, author: sally)

    result = Yuriita.filter(
      Post.all,
      "author:eebs",
      PostDefinition.build,
    )

    expect(result.relation).to contain_exactly(eebs_post)
  end

  it "returns results matching the last input" do
    eebs = create(:author, username: "eebs")
    sally = create(:author, username: "sally")
    eebs_post = create(:post, author: eebs)
    sally_post = create(:post, author: sally)

    result = Yuriita.filter(
      Post.all,
      "author:eebs author:sally",
      PostDefinition.build,
    )

    expect(result.relation).to contain_exactly(sally_post)
  end
end
