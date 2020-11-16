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

  [
    {link: 'https://youtu.be/V06FJGSQ3Ug', id: 'V06FJGSQ3Ug'},
    {link: 'https://youtu.be/nFrb-C6I6Ps', id: 'nFrb-C6I6Ps'}
  ].each do |test_link|
    it "stores youtube video id when saved <#{test_link[:link]}>" do
      species = Taxon.create(rank: 'Species', common_name: 'this species', scientific_name: 'lorem ipsum')
      expect(species.save).to be true
      video = YoutubeVideo.create(link: test_link[:link], taxon: species)
      expect(video.save).to be true
      expect(video[:youtube_id]).to eq(test_link[:id])
    end
  end
end
