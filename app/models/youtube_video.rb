class YoutubeVideo < ApplicationRecord
  belongs_to :taxon
  validates :link, presence: true
  validates_format_of :link, :with => /(https:\/\/)?(youtu.be\/|www.youtube.com\/watch\?v=)[\w]+/
end
