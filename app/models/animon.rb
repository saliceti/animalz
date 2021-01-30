class Animon < ApplicationRecord
  belongs_to :taxon
  has_many :youtube_videos
  has_one_attached :picture

  validates :taxon, presence: true

  def self.latest_created(quantity)
    Animon.order(:created_at).reverse_order.take quantity
  end

end
