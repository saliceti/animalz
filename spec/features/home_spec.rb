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
    and_2_animons
    and_a_new_youtube_video_was_added
    when_a_user_visits_the_home_page
    then_the_new_taxons_are_displayed
    and_the_new_animons_are_displayed
    and_the_new_videos_are_displayed
    and_content_is_ordered_chronologically
  end
end

def when_a_user_visits_the_home_page
  visit root_path
end

def then_they_receive_greeting_message
  expect(page).to have_text('Welcome to our planet')
end

def and_the_menus_are_displayed
  expect(page).to have_link('Home', href: root_path)
  expect(page).to have_link('Anidex', href: browse_index_path)
  expect(page).to have_link('New animon', href: new_animon_path)
  expect(page).to have_link('New taxon', href: new_taxon_path)
  expect(page).to have_link('Help', href: help_index_path)
end

def and_2_animons
  @animons = [
    Animon.new(taxon: Taxon.find_by(rank: 'Species')),
    Animon.new(taxon: Taxon.find_by(rank: 'Subspecies'))
  ]
end

def and_a_new_youtube_video_was_added
  @links = ['https://youtu.be/V06FJGSQ3U', 'https://youtu.be/V06FJGSQ3Z']
  @thumbnails = ['https://img.youtube.com/vi/V06FJGSQ3U/0.jpg', 'https://img.youtube.com/vi/V06FJGSQ3Z/0.jpg']
  @animons.each_with_index do |animon, i|
    video = YoutubeVideo.new(link: @links[i], animon: animon)
    expect(video.save).to be true
  end
end

def then_the_new_taxons_are_displayed
  Taxon.last(2).each do |taxon|
    within('td', text: "New #{taxon.rank}: #{taxon.common_name}") do
      expect(page).to have_link taxon.common_name, href: taxon_path(taxon)
    end
  end
end

def and_the_new_animons_are_displayed
  @animons.each do |animon|
    within('td', text: "New animon: #{animon.taxon.common_name}") do
      expect(page).to have_link animon.taxon.common_name, href: animon_path(animon)
    end
  end
end

def and_the_new_videos_are_displayed
  @animons.each_with_index do |animon, i|
    video = animon.youtube_videos.first
    within('tr', text: "New video added to #{animon.taxon.common_name}") do
      # TODO: Test presence of image link to animon
      expect(page).to have_css("img[src*='#{@thumbnails[i]}']")
    end
  end
end

def and_content_is_ordered_chronologically
  video_index = page.text.index("New video added to #{YoutubeVideo.last.animon.taxon.common_name}")
  animon_index = page.text.index("New animon: #{Animon.last.taxon.common_name}")
  taxon_index = page.text.index("New #{Taxon.last.rank}: #{Taxon.last.common_name}")
  expect(video_index).to be < animon_index
  expect(animon_index).to be < taxon_index
end
