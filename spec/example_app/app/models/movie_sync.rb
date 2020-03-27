class MovieSync
  def self.run(client:)
    new(client: client).run
  end

  def initialize(client:)
    @client = client
  end

  def run
    insert_or_update_movies
  end

  private

  attr_reader :client

  def insert_or_update_movies
    Movie.upsert_all(movie_data, unique_by: :tmdb_id)
  end

  def movie_data
    client.top_rated
  end

  def insert_attributes
    [
      "tmdb_id",
      "title",
      "original_title",
      "tagline",
      "overview",
      "adult",
      "status",
      "revenue",
      "runtime",
      "vote_count",
      "budget",
      "vote_average",
      "popularity",
      "release_date",
      "created_at",
      "updated_at",
    ]
  end
end
