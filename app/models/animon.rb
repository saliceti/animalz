class Animon < ApplicationRecord
  belongs_to :taxon
  has_many :youtube_videos
  has_one_attached :picture
  accepts_nested_attributes_for :taxon

  validates :taxon, presence: true

  def self.all_ordered_by_common_name
    Animon.joins(:taxon).order(:common_name)
  end

  def self.latest_created(quantity = nil)
    if quantity
      Animon.order(:created_at).reverse_order.take quantity
    else
      Animon.order(:created_at).reverse_order
    end
  end

  def self.random_animons_with_picture(quantity)
    Animon.joins(:picture_attachment).limit(quantity).order("RANDOM()")
  end

  def self.latest_animons_with_picture(quantity)
    Animon.joins(:picture_attachment).order(:updated_at).reverse_order.take quantity
  end

  def self.random_animons_with_picture_in_taxon(quantity, taxon)
    species_and_subspecies = taxon.children_at_ranks(["Species", "Subspecies"])
    @animons = Animon.joins(:taxon, :picture_attachment).where(
      taxons: { id: species_and_subspecies.map{|t| t.id} }
    ).limit(quantity).order("RANDOM()")
  end

  def self.latest_animons_with_picture_in_taxon(quantity, taxon)
    species_and_subspecies = taxon.children_at_ranks(["Species", "Subspecies"])
    @animons = Animon.joins(:taxon, :picture_attachment).where(
      taxons: { id: species_and_subspecies.map{|t| t.id} }
    ).order(:created_at).reverse_order.take quantity
  end

  def self.all_animons_in_taxon(taxon)
    species_and_subspecies = taxon.children_at_ranks(["Species", "Subspecies"])
    @animons = Animon.joins(:taxon).where(
      taxons: { id: species_and_subspecies.map{|t| t.id} }
    )
  end

  def update_points(event)
    case event
    when :added_youtube_video
      increment(:points, 10)
    end
    save
  end
end
