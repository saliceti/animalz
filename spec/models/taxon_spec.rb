require 'rails_helper'

RSpec.describe Taxon, type: :model do
  it { is_expected.to have_db_column(:rank).of_type(:string) }
  it { is_expected.to have_db_column(:common_name).of_type(:string) }
  it { is_expected.to validate_presence_of(:common_name) }
  it { is_expected.to validate_presence_of(:rank) }
  it { is_expected.to validate_uniqueness_of(:common_name) }
  it { is_expected.to have_db_column(:scientific_name).of_type(:string) }
  it { is_expected.to validate_presence_of(:scientific_name) }
  it { is_expected.to validate_uniqueness_of(:scientific_name) }
  it { is_expected.to have_db_column(:parent_id).of_type(:integer) }
  it { is_expected.to belong_to(:parent).optional.class_name('Taxon') }
  it { is_expected.to have_many(:youtube_videos) }
  it { is_expected.to have_many(:children).class_name('Taxon') }

  it "is not valid if the rank order is wrong" do
    parent = Taxon.new(rank: 'Order', common_name: 'Abcd', scientific_name: 'Abcd Defg')
    expect(parent).to be_valid
    child = Taxon.new(rank: 'Class', parent: parent, common_name: 'Abcd1', scientific_name: 'Abcd1 Defg1')
    expect(child).to_not be_valid
    expect(child.errors.details).to eq({ :parent => [{:error => "Class cannot have Order as parent"}] })
  end

end
