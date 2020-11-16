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
  has_many :youtube_videos
  validates_with RankOrderValidator

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

  def ancestors
    if parent
      parent.ancestors + [parent]
    else
      []
    end
  end

end
