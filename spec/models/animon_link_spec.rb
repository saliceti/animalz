require 'rails_helper'

RSpec.describe AnimonLink, type: :model do
  it { is_expected.to have_db_column(:url).of_type(:string) }
  it { is_expected.to have_db_column(:animon_id).of_type(:integer) }
  it { is_expected.to belong_to(:animon)}
  it { is_expected.to validate_presence_of(:url)}
end
