class MoviesController < ApplicationController
  def index
    @table = Yuriita::Table.new(
      relation: Movie.all,
      params: params.permit(:query),
      configuration: MovieDefinition.build,
      param_key: :query
    )
  end
end
