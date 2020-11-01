require 'rails_helper'

RSpec.describe YoutubeVideo, type: :model do
  it { is_expected.to have_db_column(:link).of_type(:string) }
  it { is_expected.to have_db_column(:youtube_id).of_type(:string) }
  it { is_expected.to have_db_column(:taxon_id).of_type(:integer) }
  it { is_expected.to belong_to(:taxon)}
  it { is_expected.to validate_presence_of(:link)}
  it { is_expected.to allow_value('https://www.youtube.com/watch?v=V06FJGSQ3Ug').for(:link) }
  it { is_expected.to allow_value('www.youtube.com/watch?v=V06FJGSQ3Ug').for(:link) }
  it { is_expected.to allow_value('https://youtu.be/V06FJGSQ3Ug').for(:link) }
  it { is_expected.to allow_value('youtu.be/V06FJGSQ3Ug').for(:link) }
  it { is_expected.not_to allow_value('youtu.be').for(:link) }
  it { is_expected.not_to allow_value('www.youtube.com').for(:link) }
  it { is_expected.not_to allow_value('https://www.youtube.com/watch?v=').for(:link) }
  it { is_expected.not_to allow_value('https://foo.com').for(:link) }
  it { is_expected.not_to allow_value('this is not a URL').for(:link) }
end
