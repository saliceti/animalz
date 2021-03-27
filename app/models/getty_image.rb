class GettyImage < ApplicationRecord
    belongs_to :animon

    validates :embed_code, presence: true
end
