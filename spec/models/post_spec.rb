require "rails_helper"

RSpec.describe Post, type: :model do
  describe ".published" do
    it "returns published posts" do
      published = create(:post, :published)
      create(:post, :draft)

      results = Post.published

      expect(results).to contain_exactly(published)
    end
  end

  describe ".draft" do
    it "returns draft posts" do
      create(:post, :published)
      draft = create(:post, :draft)

      results = Post.draft

      expect(results).to contain_exactly(draft)
    end
  end

  describe "author" do
    it "is required" do
      post = Post.new

      post.valid?

      expect(post.errors).to be_added(:author, :blank)
    end

    it "is a User" do
      user = User.new
      post = Post.new(author: user)

      expect(post.author).to eq user
    end
  end
end
