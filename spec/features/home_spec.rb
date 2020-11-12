require "rails_helper"
require './spec/support/helpers'

RSpec.configure do |c|
  c.include Helpers
end

feature 'Home' do
  scenario 'Visit' do
    when_a_user_visits_the_home_page
    then_they_receive_greeting_message
    and_the_menus_are_displayed
  end
  scenario 'Latest content' do
    given_a_full_taxon_hierarchy
    and_a_new_youtube_video_was_added
    when_a_user_visits_the_home_page
    then_the_new_content_is_displayed
  end
end

def when_a_user_visits_the_home_page
  visit root_path
end

def then_they_receive_greeting_message
  expect(page).to have_text('Welcome to our planet!')
end

def and_the_menus_are_displayed
  expect(page).to have_link('Home', href: root_path)
  expect(page).to have_link('Anidex', href: browse_index_path)
  expect(page).to have_link('New', href: new_taxon_path)
end

def and_a_new_youtube_video_was_added
  video = YoutubeVideo.create(link: 'https://www.youtube.com/embed/V06FJGSQ3U')
  video.save
end

def then_the_new_content_is_displayed
  # taxons
  Taxon.last(2) do |taxon|
    expect(page).to have_text "New #{taxon.rank}: #{taxon.common_name}"
    expect(page).to have_link taxon.common_name, href: taxon_path(taxon)
  end
  # video
  YoutubeVideo.last(2) do |video|
    expect(page).to have_text "New video: #{video}"
    expect(page).to have_link taxon.common_name, href: taxon_path(taxon)
  end
end
