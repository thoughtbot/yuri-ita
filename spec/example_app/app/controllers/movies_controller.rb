class MoviesController < ApplicationController
  def index
    table = build_table
    render locals: { table: table }
  end

  private

  def build_table
    Yuriita::Table.new(
      relation: Movie.all,
      params: table_params,
      configuration: MovieDefinition.build,
    )
  end

  def table_params
    params.permit(:q)
  end
end
