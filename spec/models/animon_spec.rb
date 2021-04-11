require 'rails_helper'

RSpec.describe Animon, type: :model do
  it { is_expected.to belong_to(:taxon) }
  it { is_expected.to validate_presence_of(:taxon) }
  it { is_expected.to have_many(:animon_links) }
  it { is_expected.to have_many(:youtube_videos) }
  it { is_expected.to have_many(:getty_images) }
  it { is_expected.to have_db_column(:twitter_handle) }
end
