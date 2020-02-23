FactoryBot.define do
  factory :post do
    title { "A title" }
    body { "A body" }
  end

  factory :category do
    name { "Ruby" }
  end
end
