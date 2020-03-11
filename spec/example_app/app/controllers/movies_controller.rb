class MoviesController < ApplicationController
  def index
    render locals: { movies: Movie.all }
  end
end
