class RankOrderValidator < ActiveModel::Validator
  def validate(record)
    return unless record.parent
    if Taxon::RANKS.index(record.rank) <= Taxon::RANKS.index(record.parent.rank)
      record.errors[:base] << "#{record.rank} cannot have #{record.parent.rank} as parent"
    end
  end
end

class Taxon < ApplicationRecord
  belongs_to :parent, class_name: "Taxon", optional: true
  has_many :children, class_name: "Taxon", foreign_key: "parent_id"
  has_one :animon
  has_many :youtube_videos
  validates_with RankOrderValidator
  validates :rank, presence: true
  validates :common_name, :scientific_name, presence: true, uniqueness: true

  RANKS = ['Phylum', 'Class', 'Order', 'Family', 'Subfamily', 'Tribe', 'Subtribe', 'Genus', 'Species', 'Subspecies']

  def rank_and_common_name
    "#{rank}: #{common_name}"
  end

  def self.select_rank(rank)
    raise "Unknown rank '#{rank}'" unless RANKS.include? rank
    Taxon.where(rank: rank)
  end

  def self.latest_created(quantity)
    Taxon.order(:created_at).reverse_order.take quantity
  end

  def self.available_species_and_subspecies(extra_taxon=nil)
    Taxon
      .where(rank: ['Species', 'Subspecies'])
      .left_outer_joins(:animon)
      .where(animons: {taxon_id: [nil, extra_taxon]})
  end

  def ancestors
    # Prevent infinite loop
    raise "Taxon and parent are the same: #{self.inspect}" if self == parent

    if parent
      parent.ancestors + [parent]
    else
      []
    end
  end

end
