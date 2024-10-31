require "rails_helper"

RSpec.describe Movie, type: :model do
  describe ".rumored" do
    it "returns movies with the rumored status" do
      rumored = create(:movie, :rumored)
      create(:movie, :post_production)

      results = Movie.rumored

      expect(results).to contain_exactly(rumored)
    end
  end

  describe ".post_production" do
    it "returns movies with the rumored status" do
      post_production = create(:movie, :post_production)
      create(:movie, :released)

      results = Movie.post_production

      expect(results).to contain_exactly(post_production)
    end
  end

  describe ".released" do
    it "returns movies with the rumored status" do
      released = create(:movie, :released)
      create(:movie, :cancelled)

      results = Movie.released

      expect(results).to contain_exactly(released)
    end
  end

  describe ".cancelled" do
    it "returns movies with the rumored status" do
      cancelled = create(:movie, :cancelled)
      create(:movie, :rumored)

      results = Movie.cancelled

      expect(results).to contain_exactly(cancelled)
    end
  end

  describe ".search" do
    it "searches the given field for the term" do
      duck_movie = create(:movie, title: "Mighty Ducks")
      create(:movie, title: "Cats", tagline: "Cats not ducks")

      results = Movie.search(:title, "ducks")

      expect(results).to contain_exactly(duck_movie)
    end
  end
end
