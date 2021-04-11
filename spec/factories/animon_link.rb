FactoryBot.define do

  factory :animon_link do
    sequence(:url) { |n| "https://www.montclairlocal.news/2021/04/01/the-red-fox-montclairs-cutest-carnivore-whats-in-your-backyard/#{n}/"}
    sequence(:title) { |n| "The red fox: montclair’s cutest carnivore #{n}"}
    association :animon
  end

end
