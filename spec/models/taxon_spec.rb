require 'rails_helper'

RSpec.describe Taxon, type: :model do
  it { is_expected.to have_db_column(:rank).of_type(:string) }
  it { is_expected.to have_db_column(:common_name).of_type(:string) }
  it { is_expected.to have_db_column(:scientific_name).of_type(:string) }
  it { is_expected.to have_db_column(:parent_id).of_type(:integer) }
  it { is_expected.to belong_to(:parent).optional.class_name('Taxon') }
  it { is_expected.to have_many(:youtube_videos) }
  it { is_expected.to have_many(:children).class_name('Taxon') }
end
