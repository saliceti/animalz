RANKS = ['Phylum', 'Class', 'Order', 'Family', 'Subfamily', 'Tribe', 'Subtribe', 'Genus', 'Species', 'Subspecies']

FactoryBot.define do

  factory :phylum, class: "Taxon" do
    rank { Taxon::RANKS.first }
    sequence(:common_name) { |n| "#{rank} common name #{n}" }
    sequence(:scientific_name) { |n| "#{rank} scientific name #{n}" }

    RANKS.drop(1).each_with_index do |model_rank, i|
      factory model_rank.downcase, class: "Taxon" do
        rank { model_rank }
        association :parent, factory: RANKS[i].downcase
      end
    end
  end

end
