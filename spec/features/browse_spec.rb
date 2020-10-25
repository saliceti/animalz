require "rails_helper"

def scenario_browse_by(rank)
  scenario "By #{rank}" do
    given_a_full_taxon_hierarchy
    when_a_user_visits_the_browse_page
    and_the_user_clicks_on_rank(rank)
    then_the_list_only_contains_rank(rank)
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
end

def when_a_user_visits_the_browse_page
  visit browse_index_path
end

def then_the_browse_title_is_displayed
  expect(page).to have_text('Browse all Animons')
end

def given_a_full_taxon_hierarchy
  parent_taxon = nil
  Taxon::RANKS.each do |rank|
    taxon = Taxon.create(rank: rank, common_name: "#{rank} common name", scientific_name: "#{rank} scientific name", parent: parent_taxon)
    expect(taxon.save).to be true
    parent_taxon = taxon
  end
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
