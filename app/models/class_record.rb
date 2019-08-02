class ClassRecord < ApplicationRecord
  belongs_to :phylum_record
  has_many :order_records, :dependent => :restrict_with_error
end
