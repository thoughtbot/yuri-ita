require "rails_helper"

RSpec.describe GenreSync do
  describe "#run" do
    it "fetches all genres from TMDB and inserts them into the DB" do
      comedy = attributes_for(
        :genre,
        name: "Comedy",
        created_at: Time.now,
        updated_at: Time.now
      )
      drama = attributes_for(
        :genre,
        name: "Drama",
        created_at: Time.now,
        updated_at: Time.now
      )
      client = double(:client, genres: [comedy, drama])

      GenreSync.new(client:).run

      names = Genre.all.map(&:name)
      expect(names).to contain_exactly("Comedy", "Drama")
    end
  end
end
