class Taxon < ApplicationRecord
  has_one :parent, class_name: "Taxon"
end
