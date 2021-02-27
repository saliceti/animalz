FactoryBot.define do

  factory :animon do
    association :taxon, factory: :species
  end

end
