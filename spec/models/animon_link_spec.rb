require 'rails_helper'

RSpec.describe AnimonLink, type: :model do
  it { is_expected.to have_db_column(:url).of_type(:string) }
  it { is_expected.to have_db_column(:animon_id).of_type(:integer) }
  it { is_expected.to belong_to(:animon)}
  it { is_expected.to validate_presence_of(:url)}
  it { is_expected.to allow_value('https://www.montclairlocal.news/2021/04/01/the-red-fox-montclairs-cutest-carnivore-whats-in-your-backyard/').for(:url) }
  it { is_expected.to allow_value('https://www.montclairlocal.news/').for(:url) }
  it { is_expected.to allow_value('https://www.montclairlocal.news').for(:url) }
  it { is_expected.to allow_value('https://montclairlocal.news').for(:url) }
  it { is_expected.not_to allow_value('www.montclairlocal.news/2021/04').for(:url) }
  it { is_expected.not_to allow_value('https://wwwmontclairlocalnews/2021/04').for(:url) }
end
