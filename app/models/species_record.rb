class SpeciesRecord < ApplicationRecord
  belongs_to :genus_record
  validates :name, presence: true
end
