require 'rails_helper'

RSpec.describe Animon, type: :model do
  it { is_expected.to belong_to(:taxon) }
  it { is_expected.to validate_presence_of(:taxon_id) }
  it { is_expected.to have_many(:youtube_videos) }
end
