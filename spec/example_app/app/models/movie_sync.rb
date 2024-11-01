class MovieSync
  def self.run(client:)
    new(client:).run
  end

  def initialize(client:)
    @client = client
  end

  def run
    insert_or_update_movies
    insert_or_update_movie_genres
  end

  private

  attr_reader :client

  def insert_or_update_movies
    Movie.upsert_all(movie_data, unique_by: :tmdb_id)
  end

  def insert_or_update_movie_genres
    unless movie_genre_data.empty?
      MovieGenre.upsert_all(movie_genre_data, unique_by: [:movie_id, :genre_id])
    end
  end

  def movie_data
    client.top_rated
  end

  def movie_genre_data
    client.movie_genres
  end
end
