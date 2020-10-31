class YoutubeVideo < ApplicationRecord
  belongs_to :taxon
  validates :link, presence: true
end
