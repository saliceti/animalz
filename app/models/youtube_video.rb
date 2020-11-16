class YoutubeVideo < ApplicationRecord
  URL_REGEX = /(?:https:\/\/)?(?:youtu.be\/|www.youtube.com\/watch\?v=)([\w-]+)/

  before_save :extract_youtube_id

  belongs_to :taxon
  validates :link, presence: true
  validates_format_of :link, :with => URL_REGEX

  private

  def self.latest_created(quantity)
    YoutubeVideo.order(:created_at).reverse_order.take quantity
  end

  def extract_youtube_id
    self.youtube_id = link.match(URL_REGEX).captures.first
  end

end