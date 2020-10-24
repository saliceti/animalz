class Taxon < ApplicationRecord
  has_one :parent, class_name: "Taxon"

  RANKS = ['Phylum', 'Class', 'Order', 'Family', 'Subfamily', 'Tribe', 'Subtribe', 'Genus', 'Species', 'Subspecies']

  def rank_and_common_name
    "#{rank}: #{common_name}"
  end
end
