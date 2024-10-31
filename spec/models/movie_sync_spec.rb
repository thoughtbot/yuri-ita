require "rails_helper"

RSpec.describe MovieSync do
  describe "#run" do
    it "fetches the top 100 movies from TMDB and inserts them into the DB" do
      fight_club = attributes_for(
        :movie,
        title: "Fight Club",
        created_at: Time.now,
        updated_at: Time.now
      )

      the_prestige = attributes_for(
        :movie,
        title: "The Prestige",
        created_at: Time.now,
        updated_at: Time.now
      )

      client = double(:client, top_rated: [fight_club, the_prestige], movie_genres: [])

      MovieSync.new(client:).run

      titles = Movie.all.map(&:title)
      expect(titles).to contain_exactly("Fight Club", "The Prestige")
    end
  end
end
