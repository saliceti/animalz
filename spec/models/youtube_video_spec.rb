require 'rails_helper'

RSpec.describe YoutubeVideo, type: :model do
  it { is_expected.to have_db_column(:link).of_type(:string) }
  it { is_expected.to have_db_column(:taxon_id).of_type(:integer) }
  it { is_expected.to belong_to(:taxon)}
end
