require 'rails_helper'

RSpec.describe GettyImage, type: :model do
  it { is_expected.to have_db_column(:embed_code).of_type(:string) }
  it { is_expected.to have_db_column(:animon_id).of_type(:integer) }
  it { is_expected.to belong_to(:animon)}
  it { is_expected.to validate_presence_of(:embed_code)}
end
