class PhylumRecord < ApplicationRecord
  has_many :class_records, :dependent => :restrict_with_error
  validates :name, presence: true
end
