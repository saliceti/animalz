class AnimonLink < ApplicationRecord
  belongs_to :animon
  validates :url, presence: true
end
