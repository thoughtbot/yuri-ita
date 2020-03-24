class MovieDefinition
  def self.build
    new.build
  end

  def build
    Yuriita::Configuration.new(definitions: definitions, scopes: scopes)
  end

  private

  def scopes
    { movie: movie_scope }
  end

  def definitions
    { status: status_definition, adult: adult_definition, sort: sort_definition }
  end

  def movie_scope
    Yuriita::Scope.new(
      options: search_options,
      combination: Yuriita::OrCombination,
    )
  end

  def search_options
    [title_option, tagline_option, overview_option]
  end

  def title_option
    filter = Yuriita::SearchFilter.new(
      matcher: Yuriita::Matchers::Expression.new(qualifier: "in", term: "title"),
      combination: Yuriita::AndCombination,
    ) do |relation, term|
      relation.search(:title, term)
    end

    Yuriita::Option.new(name: "In Title", filter: filter)
  end

  def tagline_option
    filter = Yuriita::SearchFilter.new(
      matcher: Yuriita::Matchers::Expression.new(qualifier: "in", term: "tagline"),
      combination: Yuriita::AndCombination,
    ) do |relation, term|
      relation.search(:tagline, term)
    end

    Yuriita::Option.new(name: "In Tagline", filter: filter)
  end

  def overview_option
    filter = Yuriita::SearchFilter.new(
      matcher: Yuriita::Matchers::Expression.new(qualifier: "in", term: "overview"),
      combination: Yuriita::AndCombination,
    ) do |relation, term|
      relation.search(:overview, term)
    end

    Yuriita::Option.new(name: "In Overview", filter: filter)
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
      matcher: Yuriita::Matchers::Expression.new(qualifier: "is", term: "rumored"),
    ) do |relation|
      relation.rumored
    end

    Yuriita::Option.new(name: "Rumored", filter: filter)
  end

  def released_option
    filter = Yuriita::ExpressionFilter.new(
      matcher: Yuriita::Matchers::Expression.new(qualifier: "is", term: "released"),
    ) do |relation|
      relation.released
    end

    Yuriita::Option.new(name: "Released", filter: filter)
  end

  def post_production_option
    filter = Yuriita::ExpressionFilter.new(
      matcher: Yuriita::Matchers::Expression.new(qualifier: "is", term: "post_production"),
    ) do |relation|
      relation.post_production
    end

    Yuriita::Option.new(name: "Post Production", filter: filter)
  end

  def cancelled_option
    filter = Yuriita::ExpressionFilter.new(
      matcher: Yuriita::Matchers::Expression.new(qualifier: "is", term: "cancelled"),
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
      matcher: Yuriita::Matchers::Expression.new(qualifier: "is", term: "adult"),
    ) do |relation|
      relation.where(adult: true)
    end

    Yuriita::Option.new(name: "Adult", filter: filter)
  end

  def safe_option
    filter = Yuriita::ExpressionFilter.new(
      matcher: Yuriita::Matchers::Expression.new(qualifier: "is", term: "safe"),
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
      matcher: Yuriita::Matchers::Expression.new(qualifier: "sort", term: "default"),
    ) do |relation|
      relation.order(vote_average: :desc)
    end

    Yuriita::Option.new(name: "Rating", filter: filter)
  end

  def title_desc_option
    filter = Yuriita::ExpressionFilter.new(
      matcher: Yuriita::Matchers::Expression.new(qualifier: "sort", term: "title-desc"),
    ) do |relation|
      relation.order(title: :desc)
    end

    Yuriita::Option.new(name: "Title Desc", filter: filter)
  end

  def title_asc_option
    filter = Yuriita::ExpressionFilter.new(
      matcher: Yuriita::Matchers::Expression.new(qualifier: "sort", term: "title-asc"),
    ) do |relation|
      relation.order(title: :asc)
    end

    Yuriita::Option.new(name: "Title Asc", filter: filter)
  end
end
