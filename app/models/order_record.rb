class OrderRecord < ApplicationRecord
  belongs_to :class_record
  has_many :family_records, :dependent => :restrict_with_error
end
