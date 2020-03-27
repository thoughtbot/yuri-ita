class GenreSync
  def self.run(client:)
    new(client: client).run
  end

  def initialize(client:)
    @client = client
  end

  def run
    insert_or_update_genres
  end

  private

  attr_reader :client

  def insert_or_update_genres
    Genre.upsert_all(genre_data, unique_by: :tmdb_id)
  end

  def genre_data
    client.genres
  end
end
