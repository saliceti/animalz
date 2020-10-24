require "rails_helper"

feature 'Taxon CRUD' do
  scenario 'Create a new taxon' do
    given_a_taxon_already_exists
    when_a_user_creates_a_child_taxon
    then_the_new_taxon_is_displayed
  end
end

def given_a_taxon_already_exists
  chordata = Taxon.create(rank: 'Phylum', common_name: 'Chordates', scientific_name: 'Chordata')
  chordata.save
  expect(Taxon.any?).to be_truthy
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

def then_the_new_taxon_is_displayed
  expect(page).to have_text 'Taxon was successfully created'
  expect(page).to have_text 'Rank: Class'
  expect(page).to have_text 'Common name: Mammals'
  expect(page).to have_text 'Scientific name: Mammalia'
end
