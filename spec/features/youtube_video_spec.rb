require "rails_helper"
require './spec/support/helpers'

RSpec.configure do |c|
  c.include Helpers
end

feature 'YouTube video' do
  scenario 'Add' do
    given_a_full_taxon_hierarchy
    given_an_animon_exists
    when_a_user_visits_an_animon
    and_adds_a_video
    then_it_is_displayed_on_animon_page
  end
end

def given_an_animon_exists
  species_taxon = Taxon.find_by rank: 'Species'
  @species_animon = Animon.create taxon: species_taxon
end

def when_a_user_visits_an_animon
  visit animon_path(@species_animon)
end

def and_adds_a_video

  expect(page).to have_link 'Add YouTube video', href: new_youtube_video_path(animon_id: @species_animon)
  click_link('Add YouTube video')
  expect(page).to have_text "Add video to #{@species_animon.taxon.common_name}"
  expect(page).to have_field "youtube_video_animon_id", with: @species_animon.id, type: :hidden
  @link = 'https://youtu.be/V06FJGSQ3U'
  fill_in :youtube_video_link, with: @link
  click_button 'commit'
end

def then_it_is_displayed_on_animon_page
  expect(current_path).to eq(animon_path(@species_animon))
  video = YoutubeVideo.last
  embed_link = "https://www.youtube.com/embed/V06FJGSQ3U"
  expect(page).to have_css("iframe[src='#{embed_link}']")
end
