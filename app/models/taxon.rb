class Taxon < ApplicationRecord
  belongs_to :parent, class_name: "Taxon", optional: true

  RANKS = ['Phylum', 'Class', 'Order', 'Family', 'Subfamily', 'Tribe', 'Subtribe', 'Genus', 'Species', 'Subspecies']

  def rank_and_common_name
    "#{rank}: #{common_name}"
  end
end
