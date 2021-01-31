# require "rails_helper"
require './spec/support/helpers'

RSpec.configure do |c|
  c.include Helpers
end

def scenario_select_taxon_rank(rank)
  scenario "#{rank}" do
    given_a_full_taxon_hierarchy
    when_a_user_visits_the_taxonomy_page
    and_the_user_clicks_on_rank rank
    then_the_list_only_contains_rank rank
    and_there_is_a_new_taxon_link_for_rank rank
  end
end

feature 'Taxonomy' do
  scenario 'Visit' do
    when_a_user_visits_the_taxonomy_page
    then_there_is_a_link_to_all_taxons
    and_there_is_a_list_of_rank_filters
  end
  scenario "All taxons" do
    given_a_full_taxon_hierarchy
    when_a_user_visits_the_taxonomy_page
    and_the_user_clicks_on_all_taxons
    then_the_taxons_are_listed
  end
  Taxon::RANKS.each do |rank|
    scenario_select_taxon_rank rank
  end
end

def when_a_user_visits_the_taxonomy_page
  visit taxonomy_index_path
end

def then_there_is_a_link_to_all_taxons
  expect(page).to have_link('Everything', href: taxons_path)
end

def and_there_is_a_list_of_rank_filters
  Taxon::RANKS.each{ |rank|
      expect(page).to have_link("📖 #{rank} list", href: taxons_path(rank: rank))
  }
end

def and_the_user_clicks_on_all_taxons
  click_on 'Everything'
end

def then_the_taxons_are_listed
  expect(page).to have_text 'Taxonomy'
  Taxon.all.each do |t|
    expect(page).to have_link t.common_name, href: taxon_path(t)
  end
end

def and_the_user_clicks_on_rank(rank)
  click_link rank
end

def then_the_list_only_contains_rank(rank)
  expect(page).to have_text "#{rank} list"
  expect(page).to have_text "#{rank} common name"
  different_rank = Taxon::RANKS.select{|r| r != rank}.first
  expect(page).not_to have_text "#{different_rank} common name"
end

def and_there_is_a_new_taxon_link_for_rank(rank)
  expect(page).to have_link("Add new #{rank}", href: new_taxon_path(rank: rank))
end
