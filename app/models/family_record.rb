class FamilyRecord < ApplicationRecord
  belongs_to :order_record
  has_many :genus_records, :dependent => :restrict_with_error
  validates :name, presence: true
end
