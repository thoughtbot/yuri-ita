class TmdbClient
  def initialize
    Tmdb::Api.key(ENV["TMDB_API_KEY"])
  end

  def top_rated
    data.map do |movie_data|
      {
        tmdb_id: movie_data.id,
        title: movie_data.title,
        original_title: movie_data.original_title,
        tagline: movie_data.tagline,
        overview: movie_data.overview,
        adult: movie_data.adult,
        status: movie_data.status,
        revenue: movie_data.revenue,
        runtime: movie_data.runtime,
        vote_count: movie_data.vote_count,
        budget: movie_data.budget,
        vote_average: movie_data.vote_average,
        popularity: movie_data.popularity,
        release_date: movie_data.release_date,
        created_at: Time.now,
        updated_at: Time.now,
      }
    end
  end

  def genres
    genre_data.map do |genre|
      {
        tmdb_id: genre.id,
        name: genre.name,
        created_at: Time.now,
        updated_at: Time.now,
      }
    end
  end

  def movie_genres
    data.map do |movie|
      movie_id = Movie.find_by(tmdb_id: movie.id).id
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

  private

  def data
    @data ||= pages.reduce([]) do |list, page|
      list + movies_for(page)
    end
  end

  def genre_data
    Tmdb::Genre.movie_list
  end

  def genres_for(movie)
    movie.genres.map do |genre|
      Genre.find_by(tmdb_id: genre.id).id
    end
  end

  def movies_for(page)
    movie_ids_on_page(page).map do |tmdb_id|
      Tmdb::Movie.detail(tmdb_id)
    end
  end

  def movie_ids_on_page(page)
    Tmdb::Movie.top_rated(page: page).results.map(&:id)
  end

  def pages
    1..5
  end
end
