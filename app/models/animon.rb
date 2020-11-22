class Animon < ApplicationRecord
  belongs_to :taxon
  has_many :youtube_videos

  validates :taxon_id, presence: true

  def self.latest_created(quantity)
    Animon.order(:created_at).reverse_order.take quantity
  end

end
