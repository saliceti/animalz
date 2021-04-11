class AnimonLink < ApplicationRecord
  belongs_to :animon
  validates :url, presence: true

  URL_REGEX = /\Ahttps:\/\/[\w-]+\.[\w\.\-\/]+\z/

  validates_format_of :url, :with => URL_REGEX
end
