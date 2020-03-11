FactoryBot.define do
  factory :post do
    title { "A title" }
    body { "A body" }
  end

  factory :category do
    name { "Ruby" }
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
  end
end
