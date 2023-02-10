class TmdbClient
  MIN_PAGE = 1
  MAX_PAGE = 10

  attr_reader :access_token

  def initialize
    @access_token = ENV.fetch("TMDB_ACCESS_TOKEN")
  end

  def top_rated
    get_movies.map do |movie|
      {
        tmdb_id: movie.id,
        title: movie.title,
        original_title: movie.original_title,
        tagline: movie.tagline,
        overview: movie.overview,
        adult: movie.adult,
        status: movie.status,
        revenue: movie.revenue,
        runtime: movie.runtime,
        vote_count: movie.vote_count,
        budget: movie.budget,
        vote_average: movie.vote_average,
        popularity: movie.popularity,
        release_date: movie.release_date,
        created_at: Time.zone.now,
        updated_at: Time.zone.now,
      }
    end
  end

  def genres
    get_genres.map do |genre|
      {
        tmdb_id: genre.id,
        name: genre.name,
        created_at: Time.zone.now,
        updated_at: Time.zone.now,
      }
    end
  end

  def movie_genres
    get_movies.map do |movie|
      movie_id = Movie.find_by!(tmdb_id: movie.id).id
      genres_for(movie).map do |genre|
        {
          movie_id: movie_id,
          genre_id: genre,
          created_at: Time.now,
          updated_at: Time.now,
        }
      end
    end.flatten
  end

  def get_movies
    @movies ||= pages.map { |page| get_movies_for_page(page) }.sum
  end

  def get_movies_for_page(page)
    get("/movie/top_rated", page: page).results.map do |movie|
      get_movie(movie.id)
    end
  end

  def get_movie(id)
    get("/movie/#{id}")
  end

  def pages
    MIN_PAGE..MAX_PAGE
  end

  def get(url, **query)
    puts "Requesting #{url}#{query.present? ? "?" : ""}#{query.to_query}"
    HTTParty.get(
      "https://api.themoviedb.org/3/#{url}",
      query: query,
      headers: { Authorization: "Bearer #{access_token}" }
    ).to_deep_struct
  end

  def get_genres
    get("/genre/movie/list").genres
  end

  def genres_for(movie)
    movie.genres.map do |genre|
      Genre.find_by!(tmdb_id: genre.id).id
    end
  end
end
