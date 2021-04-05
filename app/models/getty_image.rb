class GettyImage < ApplicationRecord
  belongs_to :animon

  validates :embed_code, presence: true
  after_save :update_points

  def update_points
    animon.update_points(:added_getty_image)
  end

end
