class Animon < ApplicationRecord
  belongs_to :taxon
  has_many :youtube_videos

  validates :taxon_id, presence: true
end
