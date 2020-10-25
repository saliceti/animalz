require "rails_helper"

feature 'Taxon CRUD' do
  scenario 'Create a new taxon' do
    given_a_taxon_already_exists
    when_a_user_creates_a_child_taxon
    then_the_user_is_redirected_to_the_show_view_of_id(2)
    and_the_new_taxon_is_displayed
  end
  scenario 'List taxons' do
    given_a_taxon_already_exists
    when_a_user_visits_the_taxon_index
    then_the_new_taxon_is_listed
  end
  scenario 'Update taxon' do
    given_a_taxon_already_exists
    when_a_user_edits_the_taxon
    then_the_user_is_redirected_to_the_show_view_of_id(1)
    then_the_new_value_is_displayed
  end
  scenario 'Delete taxon' do
    given_a_taxon_already_exists
    when_a_user_deletes_the_taxon
    then_the_user_is_redirected_to_the_index
    and_the_taxon_is_not_there
  end
end

def given_a_taxon_already_exists
  chordata = Taxon.create(rank: 'Phylum', common_name: 'Chordates', scientific_name: 'Chordata')
  chordata.save
  expect(Taxon.any?).to be true
end

def when_a_user_creates_a_child_taxon
  visit new_taxon_path
  expect(page).to have_text 'Create new taxon'
  expect(page).to have_select('taxon_parent_id', with_options: ['Phylum: Chordates'])
  select 'Class', from: 'taxon_rank'
  fill_in 'Common name', with: 'Mammals'
  fill_in 'Scientific name', with: 'Mammalia'
  select('Phylum: Chordates', from: 'taxon_parent_id')
  click_button('commit')
end

def then_the_user_is_redirected_to_the_show_view_of_id(taxon_id)
  expect(current_path).to eq(taxon_path(taxon_id))
end

def and_the_new_taxon_is_displayed
  expect(page).to have_text 'Taxon was successfully created'
  expect(page).to have_link('Class', href: taxons_path(rank: 'Class'))
  expect(page).to have_text 'Common name: Mammals'
  expect(page).to have_text 'Scientific name: Mammalia'
end

def when_a_user_visits_the_taxon_index
  visit taxons_path
end

def then_the_new_taxon_is_listed
  expect(page).to have_link('Chordates', href: taxon_path(1))
  expect(page).to have_link('Chordata', href: taxon_path(1))
end

def when_a_user_edits_the_taxon
  visit edit_taxon_path(1)
  expect(page).to have_field('taxon_common_name', type: 'text', with: 'Chordates')
  fill_in 'Common name', with: 'Chordates-NEW'
  click_button('commit')
end

def then_the_new_value_is_displayed
  expect(page).to have_text 'Taxon was successfully updated'
  expect(page).to have_text 'Common name: Chordates-NEW'
end

def when_a_user_deletes_the_taxon
  cbdriver.delete taxon_path(1)
end

def then_the_user_is_redirected_to_the_index
  expect(cbdriver.response).to be_redirect
  visit cbdriver.response.location

  expect(current_path).to eq(taxons_path)
end

def and_the_taxon_is_not_there
  expect(page).not_to have_text 'Chordates'
end

private

def cbdriver
  Capybara.current_session.driver
end
