class MovieClient
  def initialize
    Tmdb::Api.key(ENV["TMDB_API_KEY"])
  end

  def top_rated
    data.map do |movie_data|
      Movie.new(
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
      )
    end
  end

  private

  def data
    pages.reduce([]) do |list, page|
      list + Tmdb::Movie.top_rated(page: page).results
    end
  end

  def pages
    1..5
  end
end
