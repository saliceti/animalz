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
  it { is_expected.to have_many(:children).class_name('Taxon') }
  it { is_expected.to allow_value('https://en.wikipedia.org/wiki/Chordate').for(:wikipedia_page) }
  it { is_expected.not_to allow_value('en.wikipedia.org/wiki/Chordate').for(:wikipedia_page) }
  it { is_expected.not_to allow_value('https://en.wikipedia.org/Chordate').for(:wikipedia_page) }
  it { is_expected.not_to allow_value('https://another-site.com').for(:wikipedia_page) }

  it "is not valid if the rank order is wrong" do
    top = Taxon.new(rank: 'Phylum', common_name: 'Abcd0', scientific_name: 'Abcd0 Defg0')
    expect(top.save).to be true
    parent = Taxon.new(rank: 'Order', common_name: 'Abcd', scientific_name: 'Abcd Defg', parent: top)
    expect(parent.save).to be true
    child = Taxon.new(rank: 'Class', parent: parent, common_name: 'Abcd1', scientific_name: 'Abcd1 Defg1')
    expect(child).to_not be_valid
    expect(child.errors.details).to eq({:parent_id => [{:error => "Order is invalid for rank Class"}]})
  end

  it "is not valid if parent does not exist except for top rank" do
    class_taxon = Taxon.new(rank: 'Class', common_name: 'Abcd1', scientific_name: 'Abcd1 Defg1')
    expect(class_taxon).to_not be_valid
    expect(class_taxon.errors.details).to eq({:parent=>[{:error=>:blank}]})

    class_taxon = Taxon.new({"rank" => 'Class', "common_name" => 'Abcd1', "scientific_name" => 'Abcd1 Defg1', "parent_id" => "123456"})
    expect(class_taxon).to_not be_valid
    expect(class_taxon.errors.details).to eq({:parent=>[{:error=>:blank}]})

    phylum = Taxon.new(rank: 'Phylum', common_name: 'Abcd', scientific_name: 'Abcd Defg')
    expect(phylum.save).to be true

    class_taxon = Taxon.new(rank: 'Class', common_name: 'Abcd1', scientific_name: 'Abcd1 Defg1', parent: phylum)
    expect(class_taxon).to be_valid
  end
end
