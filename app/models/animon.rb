class Animon < ApplicationRecord
  belongs_to :taxon
  has_many :animon_links
  has_many :youtube_videos
  has_many :getty_images
  has_one_attached :picture
  accepts_nested_attributes_for :taxon

  validates :taxon, presence: true

  def self.all_ordered_by_common_name
    Animon.joins(:taxon).order(:common_name)
  end

  def latest_content(quantity)
    sample = 50

    @latest_content = []
    @latest_content.concat animon_links.order(:created_at).reverse_order.take sample
    @latest_content.concat youtube_videos.order(:created_at).reverse_order.take sample
    @latest_content.concat getty_images.order(:created_at).reverse_order.take sample
    @latest_content = @latest_content.sort_by(&:created_at).reverse
    @latest_content = @latest_content[0, quantity]
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
    with_lock do
      case event
      when :added_animon_link
        increment(:points, 10)
      when :added_youtube_video
        increment(:points, 10)
      when :added_getty_image
        increment(:points, 10)
      end

      save
    end
  end

end
