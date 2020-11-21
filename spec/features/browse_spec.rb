require "rails_helper"
require './spec/support/helpers'

RSpec.configure do |c|
  c.include Helpers
end

def scenario_browse_by(rank)
  scenario "By #{rank}" do
    given_a_full_taxon_hierarchy
    when_a_user_visits_the_browse_page
    and_the_user_clicks_on_rank rank
    then_the_list_only_contains_rank rank
  end
end

feature 'Browse' do
  scenario 'Visit' do
    when_a_user_visits_the_browse_page
    then_the_browse_title_is_displayed
  end

  Taxon::RANKS.each do |rank|
    scenario_browse_by rank
  end

  scenario "All animons" do
    given_a_full_taxon_hierarchy
    and_an_animon_is_linked_to_a_taxon
    when_a_user_visits_the_browse_page
    and_the_user_clicks_on_all_animons
    then_the_animon_is_listed
  end
end

def when_a_user_visits_the_browse_page
  visit browse_index_path
end

def then_the_browse_title_is_displayed
  expect(page).to have_text('Browse all Animons')
end

def and_the_user_clicks_on_rank(rank)
  click_link "By #{rank}"
end

def then_the_list_only_contains_rank(rank)
  expect(page).to have_text "#{rank} list"
  expect(page).to have_text "#{rank} common name"
  different_rank = Taxon::RANKS.select{|r| r != rank}.first
  expect(page).not_to have_text "#{different_rank} common name"
end

def and_an_animon_is_linked_to_a_taxon
  species = Taxon.where(rank: 'Species').first
  @animon = Animon.new(taxon: species)
  @animon.save
end

def and_the_user_clicks_on_all_animons
  click_on 'All animons'
end

def then_the_animon_is_listed
  expect(page).to have_link @animon.taxon.common_name, href: animon_path(@animon)
  expect(page).to have_link "#{@animon.taxon.rank}: #{@animon.taxon.scientific_name}", href: taxon_path(@animon.taxon)
end
