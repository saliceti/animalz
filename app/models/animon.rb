class Animon < ApplicationRecord
  belongs_to :taxon

  validates :taxon_id, presence: true
end
