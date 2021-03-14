class RankOrderValidator < ActiveModel::Validator
  def validate(record)
    return unless record.parent
    # Parent rank must be lower than child's
    if Taxon::RANKS.index(record.rank) <= Taxon::RANKS.index(record.parent.rank)
      record.errors.add(:parent_id, "#{record.parent.rank} is invalid for rank #{record.rank}")
    end
  end
end

class Taxon < ApplicationRecord
  RANKS = ['Phylum', 'Class', 'Order', 'Family', 'Subfamily', 'Tribe', 'Subtribe', 'Genus', 'Species', 'Subspecies']
  WIKIPEDIA_URL_REGEX = /https:\/\/en.wikipedia.org\/wiki\/[\w_-]+/

  belongs_to :parent, class_name: "Taxon", optional: true
  has_many :children, class_name: "Taxon", foreign_key: "parent_id"
  has_one :animon

  validates :parent, presence: true, unless: :is_top_rank?
  validates_with RankOrderValidator
  validates :rank, presence: true
  validates :common_name, :scientific_name, presence: true, uniqueness: true
  validates_format_of :wikipedia_page, :with => WIKIPEDIA_URL_REGEX, unless: -> { wikipedia_page.blank? }

  def rank_and_common_name
    "#{rank}: #{common_name}"
  end

  def is_top_rank?
    Taxon::RANKS.index(rank) == 0
  end

  def children_at_ranks(children_ranks)
    result_array = []
    children.each do |c|
      result_array.append(c) if children_ranks.include? c.rank
      grand_children = c.children_at_ranks(children_ranks)
      result_array = result_array.concat(grand_children) unless grand_children.empty?
    end
    return result_array
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

  def self.in_ranks(ranks)
    Taxon.where(rank: ranks)
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
