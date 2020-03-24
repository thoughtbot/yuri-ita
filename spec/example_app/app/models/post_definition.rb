class PostDefinition
  def self.build
    new.build
  end

  def build
    Yuriita::Configuration.new(definitions: definitions, scopes: scopes)
  end

  private

  def scopes
    { post: post_scope }
  end

  def definitions
    {
      published: published_definition,
      category: category_definition,
      sort: sort_definition,
    }
  end

  def post_scope
    Yuriita::Scope.new(
      options: search_options,
      combination: Yuriita::OrCombination,
    )
  end

  def search_options
    [title_option, body_option, description_option]
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

  def body_option
    filter = Yuriita::SearchFilter.new(
      matcher: Yuriita::Matchers::Expression.new(qualifier: "in", term: "body"),
      combination: Yuriita::AndCombination,
    ) do |relation, term|
      relation.search(:body, term)
    end

    Yuriita::Option.new(name: "In Body", filter: filter)
  end

  def description_option
    filter = Yuriita::SearchFilter.new(
      matcher: Yuriita::Matchers::Expression.new(qualifier: "in", term: "description"),
      combination: Yuriita::AndCombination,
    ) do |relation, term|
      relation.search(:description, term)
    end

    Yuriita::Option.new(name: "In Description", filter: filter)
  end

  def published_definition
    Yuriita::SingleDefinition.new(options: published_options)
  end

  def published_options
    [
      published_option,
      draft_option,
    ]
  end

  def published_option
    filter = Yuriita::ExpressionFilter.new(
      matcher: Yuriita::Matchers::Expression.new(qualifier: "is", term: "published"),
    ) do |relation|
      relation.published
    end

    Yuriita::Option.new(name: "Published", filter: filter)
  end

  def draft_option
    filter = Yuriita::ExpressionFilter.new(
      matcher: Yuriita::Matchers::Expression.new(qualifier: "is", term: "draft"),
    ) do |relation|
      relation.draft
    end

    Yuriita::Option.new(name: "Draft", filter: filter)
  end

  def category_definition
    Yuriita::MultipleDefinition.new(
      options: category_options,
      combination: Yuriita::OrCombination,
    )
  end

  def category_options
    Category.find_each.map do |category|
      name = category.name
      filter = Yuriita::ExpressionFilter.new(
        matcher: Yuriita::Matchers::Expression.new(qualifier: "category", term: name),
      ) do |relation|
        relation.joins(:categories).where(categories: { name: name })
      end

      Yuriita::Option.new(name: name, filter: filter)
    end
  end

  def sort_definition
    Yuriita::ExclusiveDefinition.new(
      options: sort_options,
      default: title_desc_option,
    )
  end

  def sort_options
    [title_desc_option, title_asc_option]
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
