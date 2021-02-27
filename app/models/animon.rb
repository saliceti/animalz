class Animon < ApplicationRecord
  belongs_to :taxon
  has_many :youtube_videos
  has_one_attached :picture
  accepts_nested_attributes_for :taxon

  validates :taxon, presence: true

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
end
