FactoryBot.define do
  factory :post do
    title { "A title" }
    body { "A body" }
    author

    trait :published do
      published { true }
    end

    trait :draft do
      published { false }
    end
  end

  factory :category do
    name { "Ruby" }
  end

  factory :author, class: "User" do
    username { "username" }
  end

  sequence(:tmdb_id) { |n| n }

  factory :movie do
    tmdb_id
    title { "Fight Club" }
    original_title { "Fight Club" }
    tagline { "How much can you know about yourself if you've never been in a fight?" }
    overview { "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion." }
    adult { false }
    status { "Released" }
    revenue { 100_853_753 }
    runtime { 139 }
    vote_count { 18_307 }
    budget { 63_000_000 }
    vote_average { 8.4 }
    popularity { 34.117 }
    release_date { "1999-10-12" }

    trait :rumored do
      status { Movie::Status::RUMORED }
    end

    trait :post_production do
      status { Movie::Status::POST_PRODUCTION }
    end

    trait :released do
      status { Movie::Status::RELEASED }
    end

    trait :cancelled do
      status { Movie::Status::CANCELLED }
    end
  end

  factory :query, class: "Yuriita::Query" do
    skip_create

    inputs { [] }

    initialize_with { new(inputs: inputs) }
  end

  factory :expression, class: "Yuriita::Inputs::Expression" do
    skip_create

    qualifier { "is" }
    term { "published" }

    initialize_with { new(qualifier, term) }
  end

  factory :keyword, class: "Yuriita::Inputs::Keyword" do
    skip_create

    value { "cats" }

    initialize_with { new(value) }
  end

  factory :option, class: "Yuriita::Option" do
    skip_create

    name { "Option Name" }
    filter { build(:expression_filter) }

    initialize_with { new(name: name, filter: filter) }
  end

  factory :expression_filter, class: "Yuriita::ExpressionFilter" do
    skip_create

    input { build(:expression) }
    block { ->(relation) { relation } }

    initialize_with { new(input: input, &block) }
  end

  factory :search_filter, class: "Yuriita::SearchFilter" do
    skip_create

    input { build(:expression, qualifier: "in") }
    combination { Yuriita::AndCombination }

    block { ->(relation, term) { relation } }

    initialize_with { new(input: input, combination: combination, &block) }
  end

  factory :genre do
    tmdb_id
    name { "Comedy" }
  end
end
