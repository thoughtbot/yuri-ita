class MovieDefinition
  def self.build
    new.build
  end

  def build
    Yuriita::Configuration.new(definitions)
  end

  private

  def definitions
    {
      status: status_definition,
      adult: adult_definition,
      sort: sort_definition,
      movie: movie_scope,
    }
  end

  def movie_scope
    Yuriita::Scope.new(
      options: search_options,
      combination: Yuriita::OrCombination,
    )
  end

  def search_options
    [title_option, tagline_option]
  end

  def title_option
    filter = Yuriita::SearchFilter.new(
      input: Yuriita::Inputs::Scope.new("in", "title"),
      combination: Yuriita::AndCombination,
    ) do |relation, term|
      relation.search(:title, term)
    end

    Yuriita::Option.new(name: "In Title", filter: filter)
  end

  def tagline_option
    filter = Yuriita::SearchFilter.new(
      input: Yuriita::Inputs::Scope.new("in", "tagline"),
      combination: Yuriita::AndCombination,
    ) do |relation, term|
      relation.search(:tagline, term)
    end

    Yuriita::Option.new(name: "In Tagline", filter: filter)
  end

  def status_definition
    Yuriita::MultipleDefinition.new(
      options: status_options,
      combination: Yuriita::OrCombination,
    )
  end

  def status_options
    [
      rumored_option,
      post_production_option,
      released_option,
      cancelled_option,
    ]
  end

  def rumored_option
    filter = Yuriita::ExpressionFilter.new(
      input: Yuriita::Inputs::Expression.new("is", "rumored"),
    ) do |relation|
      relation.rumored
    end

    Yuriita::Option.new(name: "Rumored", filter: filter)
  end

  def released_option
    filter = Yuriita::ExpressionFilter.new(
      input: Yuriita::Inputs::Expression.new("is", "released"),
    ) do |relation|
      relation.released
    end

    Yuriita::Option.new(name: "Released", filter: filter)
  end

  def post_production_option
    filter = Yuriita::ExpressionFilter.new(
      input: Yuriita::Inputs::Expression.new("is", "post-production"),
    ) do |relation|
      relation.post_production
    end

    Yuriita::Option.new(name: "Post Production", filter: filter)
  end

  def cancelled_option
    filter = Yuriita::ExpressionFilter.new(
      input: Yuriita::Inputs::Expression.new("is", "cancelled"),
    ) do |relation|
      relation.cancelled
    end

    Yuriita::Option.new(name: "Cancelled", filter: filter)
  end

  def adult_definition
    Yuriita::SingleDefinition.new(options: [adult_option, safe_option])
  end

  def adult_option
    filter = Yuriita::ExpressionFilter.new(
      input: Yuriita::Inputs::Expression.new("is", "adult"),
    ) do |relation|
      relation.where(adult: true)
    end

    Yuriita::Option.new(name: "Adult", filter: filter)
  end

  def safe_option
    filter = Yuriita::ExpressionFilter.new(
      input: Yuriita::Inputs::Expression.new("is", "safe"),
    ) do |relation|
      relation.where(adult: false)
    end

    Yuriita::Option.new(name: "Safe", filter: filter)
  end

  def sort_definition
    Yuriita::ExclusiveDefinition.new(
      options: sort_options,
      default: rating_sort_option,
    )
  end

  def sort_options
    [rating_sort_option, title_asc_option, title_desc_option]
  end

  def rating_sort_option
    filter = Yuriita::ExpressionFilter.new(
      input: Yuriita::Inputs::Sort.new("sort", "default"),
    ) do |relation|
      relation.order(vote_average: :desc)
    end

    Yuriita::Option.new(name: "Rating", filter: filter)
  end

  def title_desc_option
    filter = Yuriita::ExpressionFilter.new(
      input: Yuriita::Inputs::Sort.new("sort", "title-desc"),
    ) do |relation|
      relation.order(title: :desc)
    end

    Yuriita::Option.new(name: "Title Desc", filter: filter)
  end

  def title_asc_option
    filter = Yuriita::ExpressionFilter.new(
      input: Yuriita::Inputs::Sort.new("sort", "title-asc"),
    ) do |relation|
      relation.order(title: :asc)
    end

    Yuriita::Option.new(name: "Title Asc", filter: filter)
  end
end
