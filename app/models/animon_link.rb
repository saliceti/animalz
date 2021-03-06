class AnimonLink < ApplicationRecord
  belongs_to :animon
  validates :title, presence: true, uniqueness: true
  validates :url, presence: true, uniqueness: true

  after_save :update_points

  URL_REGEX = /\Ahttps:\/\/[\w-]+\.[\w\.\-\/]+\z/

  validates_format_of :url, :with => URL_REGEX

  private

  def update_points
    animon.update_points(:added_animon_link)
  end
end
