class GenusRecord < ApplicationRecord
  belongs_to :family_record
  has_many :species_records, :dependent => :restrict_with_error
end
