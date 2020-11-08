require "rails_helper"
require './spec/support/helpers'

RSpec.configure do |c|
  c.include Helpers
end

feature 'YouTube video' do
  scenario 'Add' do
    given_a_full_taxon_hierarchy
    when_a_user_edits_an_animal
    and_adds_a_video
    then_it_is_displayed_on_animals_page
  end
end

def when_a_user_edits_an_animal
  @species = Taxon.where(rank: 'Species').first
  visit edit_taxon_path(@species)
end

def and_adds_a_video
  expect(page).to have_link 'Add YouTube video', href: new_youtube_video_path(taxon: @species)
  click_link('Add YouTube video')
  expect(page).to have_text "Add video to #{@species.common_name}"
  expect(page).to have_field "youtube_video_taxon_id", with: @species.id, type: :hidden
  @link = 'https://youtu.be/V06FJGSQ3U'
  fill_in :youtube_video_link, with: @link
  click_button 'commit'
end

def then_it_is_displayed_on_animals_page
  expect(current_path).to eq(taxon_path(@species))
  video = YoutubeVideo.last
  embed_link = "https://www.youtube.com/embed/V06FJGSQ3U"
  iframe = find('iframe')
  expect(iframe[:src]).to eq(embed_link)
end
