require "rails_helper"

RSpec.describe Post, type: :model do
  describe ".published" do
    it "returns published posts" do
      published = create(:post, :published)
      draft = create(:post, :draft)

      results = Post.published

      expect(results).to contain_exactly(published)
    end
  end

  describe ".draft" do
    it "returns draft posts" do
      published = create(:post, :published)
      draft = create(:post, :draft)

      results = Post.draft

      expect(results).to contain_exactly(draft)
    end
  end
end
