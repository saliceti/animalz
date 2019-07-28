class Family < ApplicationRecord
  has_many :animals, :dependent => :restrict_with_error
end
